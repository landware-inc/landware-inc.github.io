import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_login_test/screens/component/basket.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';
import 'package:kakao_login_test/screens/component/homebasketcard.dart';
import 'package:kakao_login_test/screens/main_screen.dart';
import '../common/commondata.dart';
import '../status/controller.dart';
import 'component/asset_card.dart';


class HomeBasketListViewScreen extends StatelessWidget {
  const HomeBasketListViewScreen({Key? key}) : super(key: key);

  Future<List> paginationAssetList() async {
    final controller = Get.put(Controller());
    final String minPrice;
    final String maxPrice;
    String minPrice2 = '0';
    String maxPrice2 = '0';
    String minSize = '0';
    String maxSize = '300';
    final String callname;
    final String roomCount;
    final String gubun;

    if (controller.selectGubun.value == '전세') {
      maxPrice = controller.maxJeonse.value.toString();
      minPrice = controller.minJeonse.value.toString();
    } else if (controller.selectGubun.value == '월세') {
      minPrice = '${controller.minDeposit.value.toString()}';
      maxPrice = '${controller.maxDeposit.value.toString()}';
      minPrice2 = '${controller.minMonthly.value.toString()}';
      maxPrice2 = '${controller.maxMonthly.value.toString()}';
    } else {
      minPrice = '${controller.minPrice.value.toString()}';
      maxPrice = '${controller.maxPrice.value.toString()}';
    }
    minSize = '${controller.minSize.value.toString()}';
    maxSize = '${controller.maxSize.value.toString()}';
    callname = '${controller.selectCallname.value}';
    roomCount = '${controller.roomCount.value}';
    gubun = '${controller.selectGubun.value}';

    try {
      final dio = Dio();
      List<basketItems> basketList = [];
      homeBasket = [];

      basketList  = await getAllItems();
      // print('==============');
      // print(basketList[0].id);


      while (basketList.length > 0) {
        homeBasket.add(basketList[0].id);
        basketList.removeAt(0);
      }

      if(homeBasket.length == 0) {
        return [];
      }
      final response = await dio.post(
          '$appServerURL/baskethome',
          data: {
            'ids': '${homeBasket.toSet().toString()}',
          }
      );


      dio.close();

      homeBasket = [];
      return response.data;


    } catch(e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('관심 등록 목록'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Get.to(() => LoginSignupScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      bottomNavigationBar: BottomMenuBar(),

      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
              future: paginationAssetList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: AssetBasketCard(
                                id: snapshot.data[index]['id'],
                                image: Image.network(
                                  snapshot.data[index]['img1'] == ''
                                      ? '$appServerURL/sample.jpg'
                                      : '$appServerURL/${snapshot.data[index]['img1']}',
                                  fit: BoxFit.cover,
                                ),
                                callname: snapshot.data[index]['callname'],
                                price: snapshot.data[index]['price'],
                                price2: snapshot.data[index]['price2'] ?? 0,
                                price3: snapshot.data[index]['price3'] ?? 0,
                                price4: snapshot.data[index]['price4'] ?? 0,
                                room: snapshot.data[index]['room'] ?? 0,
                                bath: snapshot.data[index]['bath'] ?? 0,
                                size: snapshot.data[index]['size'],
                                direction: snapshot.data[index]['direction'],
                                indate: snapshot.data[index]['indate'],
                                floor: snapshot.data[index]['floor'],
                                totalfloor: snapshot.data[index]['totalfloor'] ?? 0,
                                type: snapshot.data[index]['type'] ?? '',
                              ),
                            );
                          },
                          childCount: snapshot.data.length,
                        ),
                      ),
                    ],
                  );

                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('선택한 조건의 물건이 없습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('확인'),
              ),
            ],
          );
        }
    );
  }
}
