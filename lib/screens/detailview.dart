import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/commondata.dart';


class DetailViewScreen extends StatelessWidget {
  final int id;
  const DetailViewScreen({
    required this.id,
    Key? key}) : super(key: key);

  Future<List> pagenationDetailData() async {
    final dio = Dio();
    final response = await dio.post(
        '$appServerURL/homedetail',
        data: {
          'id': id,
        }
    );
    return response.data;
  }

  @override
  Widget build(BuildContext context)  {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail View'),
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
        child: FutureBuilder(
          future: pagenationDetailData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.width / 3) * 2,
                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          snapshot.data[0]['img1'] == ''
                              ? '$appServerURL/sample.jpg'
                              : '$appServerURL/${snapshot.data[0]['img1']}',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Text(snapshot.data[0]['callname']),
                    Text(snapshot.data[0]['type'] ?? ''),
                    Text(snapshot.data[0]['status'] ?? ''),
                    Text(snapshot.data[0]['division'] ?? ''),
                    Text(snapshot.data[0]['addr'] ?? ''),
                    Text(snapshot.data[0]['size'] ?? ''),
                    Text(snapshot.data[0]['date'] ?? ''),
                    Text(snapshot.data[0]['phone1'] ?? ''),
                    Text(snapshot.data[0]['rebuild'] ?? ''),
                    Text(snapshot.data[0]['description'] ?? ''),
                    Text(snapshot.data[0]['jeonse'].toString()),
                    Text(snapshot.data[0]['salesprice'].toString()),
                    Text(snapshot.data[0]['deposit'].toString()),
                    Text(snapshot.data[0]['monthly'].toString()),
                    Text(snapshot.data[0]['currentdeposit'].toString()),
                    Text(snapshot.data[0]['currentmonthly'].toString()),
                    Text(snapshot.data[0]['firstprice'].toString()),
                    Text(snapshot.data[0]['realprice'].toString()),
                    Text(snapshot.data[0]['premium'].toString()),
                    Text(snapshot.data[0]['sizetype']),
                    Text(snapshot.data[0]['direction']),
                    Text(snapshot.data[0]['indate']),
                    Text(snapshot.data[0]['floor']),
                    Text(snapshot.data[0]['img1'] ?? ''),
                    Text(snapshot.data[0]['img2'] ?? ''),
                    Text(snapshot.data[0]['img3'] ?? ''),
                    Text(snapshot.data[0]['img4'] ?? ''),
                    Text(snapshot.data[0]['img5'] ?? ''),
                    Text(snapshot.data[0]['img6'] ?? ''),
                  ],
                ),
              );
              // return CustomScrollView(
              //   slivers: [
              //     SliverList(
              //       delegate: SliverChildBuilderDelegate(
              //             (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.only(top: 10.0),
              //             child: AssetCard(
              //               id: snapshot.data[index]['id'],
              //               image: Image.network(
              //                 snapshot.data[index]['img1'] == ''
              //                     ? '$appServerURL/sample.jpg'
              //                     : '$appServerURL/${snapshot.data[index]['img1']}',
              //                 fit: BoxFit.cover,
              //               ),
              //               callname: snapshot.data[index]['callname'],
              //               price: snapshot.data[index]['jeonse'] ?? 0,
              //               room: snapshot.data[index]['room'] ?? 0,
              //               bath: snapshot.data[index]['bath'] ?? 0,
              //               sizetype: snapshot.data[index]['sizetype'],
              //               direction: snapshot.data[index]['direction'],
              //               indate: snapshot.data[index]['indate'],
              //               floor: snapshot.data[index]['floor'],
              //             ),
              //           );
              //         },
              //         childCount: snapshot.data.length,
              //       ),
              //     ),
              //   ],
              // );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
