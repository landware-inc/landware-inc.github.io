import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/commondata.dart';
import '../status/controller.dart';
import 'component/asset_card.dart';


class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  Future<List> paginationAssetList() async {
    final controller = Get.put(Controller());
    final String minPrice;
    final String maxPrice;
    String minPrice2 = '0';
    String maxPrice2 = '0';
    String minSize = '0';
    String maxSize = '300';
    final String callname;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('List test'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Get.back();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
