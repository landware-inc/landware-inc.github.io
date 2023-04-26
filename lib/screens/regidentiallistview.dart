import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_login_test/screens/commercialscreen.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';
import 'package:kakao_login_test/screens/homebasketlist.dart';
import 'package:kakao_login_test/screens/main_screen.dart';
import 'package:kakao_login_test/screens/registrationscreen.dart';
import 'package:kakao_login_test/screens/residentialscreen.dart';
import 'package:kakao_login_test/screens/startingscreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/commondata.dart';
import '../status/controller.dart';
import 'component/asset_card.dart';


class RegidentialListViewScreen extends StatelessWidget {
  const RegidentialListViewScreen({Key? key}) : super(key: key);

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

      final response = await dio.post(
          '$appServerURL/selected',
          data: {
            'gubun': '${controller.selectGubun.value}',
            'callname': '${callname}',
            'minp': '${minPrice}',
            'maxp': '${maxPrice}',
            'minp2': '${minPrice2}',
            'maxp2': '${maxPrice2}',
            'mins': '${minSize}',
            'maxs': '${maxSize}',
            'roomcount': '${roomCount}',
          }
      );


      dio.close();


      return response.data;


    } catch(e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;
    final controller = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('주거용 부동산'),
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
                                child: AssetCard(
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
                                  room: snapshot.data[index]['room'] ?? 0,
                                  bath: snapshot.data[index]['bath'] ?? 0,
                                  sizetype: snapshot.data[index]['sizetype'],
                                  direction: snapshot.data[index]['direction'],
                                  indate: snapshot.data[index]['indate'],
                                  floor: snapshot.data[index]['floor'],
                                  type: snapshot.data[index]['type'] ?? '',
                                  gubun: controller.selectGubun.value,
                                  addr: snapshot.data[index]['addr'],
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
