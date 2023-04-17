import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/commondata.dart';
import '../map/maptest.dart';


class DetailViewScreen extends StatelessWidget {
  final int id;
  double _lat = 0.0;
  double _lng = 0.0;
  DetailViewScreen({
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

    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${response.data[0]['addr']}&key=$googleMapKey&language=ko';

    final responseGps = await dio.get(gpsUrl);

    var rst = jsonDecode(responseGps.toString());

    _lat = rst['results'][0]['geometry']['location']['lat'];
    _lng = rst['results'][0]['geometry']['location']['lng'];
    // print(response.data[0]['addr']);
    // print ('========================================');
    // print(_lat.toString());
    // print('========================================');

    dio.close();
    return response.data;
  }




  @override
  Widget build(BuildContext context)  {
    final _authentication = FirebaseAuth.instance;
    var f = NumberFormat('###,###,###,###');

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
      body: PageView(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: pagenationDetailData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: (MediaQuery.of(context).size.width / 5) * 3,
                          child: PageView(
                                  children: [
                                      ClipRRect(
                                        child: Image.network(
                                          snapshot.data[0]['img1'] == ''
                                              ? '$appServerURL/sample.jpg'
                                              : '$appServerURL/${snapshot.data[0]['img1']}',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ClipRRect(
                                      child: Image.network(
                                        snapshot.data[0]['img2'] == ''
                                            ? '$appServerURL/sample.jpg'
                                            : '$appServerURL/${snapshot.data[0]['img2']}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    ClipRRect(
                                      child: Image.network(
                                        snapshot.data[0]['img3'] == ''
                                            ? '$appServerURL/sample.jpg'
                                            : '$appServerURL/${snapshot.data[0]['img3']}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    ClipRRect(
                                      child: Image.network(
                                        snapshot.data[0]['img4'] == ''
                                            ? '$appServerURL/sample.jpg'
                                            : '$appServerURL/${snapshot.data[0]['img4']}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    ClipRRect(
                                      child: Image.network(
                                        snapshot.data[0]['img5'] == ''
                                            ? '$appServerURL/sample.jpg'
                                            : '$appServerURL/${snapshot.data[0]['img5']}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    ClipRRect(
                                      child: Image.network(
                                        snapshot.data[0]['img6'] == ''
                                            ? '$appServerURL/sample.jpg'
                                            : '$appServerURL/${snapshot.data[0]['img6']}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ],
                            ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data[0]['callname'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                              snapshot.data[0]['type'] ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '면적 : ${snapshot.data[0]['size'] ?? ''} ㎡   (${snapshot.data[0]['sizetype'] ?? ''} 타입)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            '${snapshot.data[0]['floor'] ?? ''}층',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),                          
                          Text(
                            '${snapshot.data[0]['direction'] ?? ''}향',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                      Text(
                        '입주가능일자 : ${snapshot.data[0]['indate']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      if(snapshot.data[0]['jeonse'] > 0)
                        Text(
                          '전세가 : ${f.format(int.parse(snapshot.data[0]['jeonse'].toString()))}만원',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      if(snapshot.data[0]['deposit'] > 0)
                        Row(
                          children: [
                            Text(
                              '보증금 : ${f.format(int.parse(snapshot.data[0]['deposit'].toString()))}만원',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              ' / 월세 : ${f.format(int.parse(snapshot.data[0]['monthly'].toString()))}만원',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      if(snapshot.data[0]['salesprice'] > 0)
                        Text(
                          '매매가 : ${f.format(int.parse(snapshot.data[0]['salesprice'].toString()))}만원',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '연락처 : ${snapshot.data[0]['phone1'] ?? ''}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.primary, thickness: 1.0),
                      Text('접수일자 : ${DateFormat('yyyy/MM/dd').format(DateTime.parse(snapshot.data[0]['date']))}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text('비고 : ${snapshot.data[0]['description'] ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '상세주소 : ${snapshot.data[0]['addr'] ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      // Text(snapshot.data[0]['rebuild'] ?? ''),
                      // Text(snapshot.data[0]['description'] ?? ''),
                      // Text(snapshot.data[0]['currentdeposit'].toString()),
                      // Text(snapshot.data[0]['currentmonthly'].toString()),
                      // Text(snapshot.data[0]['firstprice'].toString()),
                      // Text(snapshot.data[0]['realprice'].toString()),
                      // Text(snapshot.data[0]['premium'].toString()),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
                }
              },
            ),
          ),
          Container(
            child: FutureBuilder(
              future: pagenationDetailData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    mapType: MapType.terrain,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_lat, _lng),
                      zoom: 17,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('marker_1'),
                        position: LatLng(_lat, _lng),
                      ),
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
