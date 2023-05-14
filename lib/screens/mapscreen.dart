import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_login_test/screens/commdetailview.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';

import '../common/commondata.dart';

var setNum = 0;

final _listController = ScrollController();
List<Marker> _markers = [];
double _lat = 35.1645654;
double _lng = 129.1774185;
List<dynamic> _result = [];



late GoogleMapController _mapController;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Map<String, String> formData = {};
  final _searchController = TextEditingController();
  String _floor = '0';
  String _type = 'C';
  final _size = TextEditingController();
  final _deposit = TextEditingController();
  final _monthly = TextEditingController();
  final _salesprice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<List> pagenationMapData() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    _lat = position.latitude;
    _lng = position.longitude;
    print(setNum);
    if(setNum == 0) {
      // final dio = Dio();
      //
      // final response2 = await dio.post('$appServerURL/nearlist', data: {
      //   'id': 1,
      //   'lat': _lat,
      //   'lng': _lng,
      //   'type': 'C',
      // });

      //   if (response2.data.length > 0) {
      //     for (int i = 0; i < response2.data.length; i++) {
      //       _markers.add(
      //         Marker(
      //           markerId: MarkerId('marker_${i + 1}'),
      //           position: LatLng((response2.data[i]['lat'] / 1.0),
      //               (response2.data[i]['lng'] / 1.0)),
      //           icon: BitmapDescriptor.defaultMarkerWithHue(
      //               BitmapDescriptor.hueGreen),
      //           infoWindow: InfoWindow(
      //             onTap: () {
      //               print('marker_${i + 1} clicked');
      //               Get.offAll(
      //                 CommDetailViewScreen(
      //                   id: response2.data[i]['id'],
      //                 ),
      //               );
      //             },
      //             title: response2.data[i]['sub_addr'],
      //             snippet:
      //             '${(response2.data[i]['deposit'] / 10000).round()}/${(response2.data[i]['monthly'] / 10000).round()} ${response2.data[i]['size']}평',
      //           ),
      //           onTap: () {
      //             // _listController.animateTo(
      //             //   i * 100.0,
      //             //   duration: const Duration(milliseconds: 900),
      //             //   curve: Curves.fastOutSlowIn,
      //             // );
      //             _listController.jumpTo(i * 110.0);
      //           },
      //
      //           //   print('marker_${i + 1} clicked');
      //           //   getx.Get.to(
      //           //     CommDetailViewScreen(
      //           //       id: response2.data[i]['id'],
      //           //     ),);
      //           // },
      //         ),
      //       );
      //     }
      //   }
      //   setNum = 1;
      //   dio.close();
      //   return response2.data;
      //
      // } else {
      //   return [];
      // }
    }
  return [];
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   title: const Text('지도 보기'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Get.to(() => const MapScreen());
      //       },
      //       icon: const Icon(Icons.map),
      //     ),
      //   ],
      // ),
      body: Container(
        child: kIsWeb ? _webMap() : _androidMap(),
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }


  Widget _webMap() {

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GoogleMap(
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference(1, 20),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(_lat, _lng),
                  zoom: 18,
                ),
                 onMapCreated: (GoogleMapController controller) {
                   _mapController = controller;
                 },
                markers: Set.from(_markers),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: _result.length,
                controller: _listController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            child: Image.network(
                              _result[index]['img_1'] == ''
                                  ? '$appServerURL/sample.jpg'
                                  : '$appServerURL/${_result[index]['img_1']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            height: 88,
                            width: MediaQuery.of(context).size.width * 0.25 - 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _result[index]['sub_addr'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '보:${(_result[index]['deposit'] / 10000).round()}/${(_result[index]['monthly'] / 10000).round()}    ${_result[index]['size']}평 ${_result[index]['floor']}층',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '관리비:${_result[index]['adminprice']}  권리금:${(_result[index]['entitleprice'] / 10000).round()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                if(_result[index]['salesprice'] > 0)
                                  Text(
                                    '매매가:${(_result[index]['salesprice'] / 10000).round()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                Text(
                                  '엘리베이터:${_result[index]['eliv'] == 0? '있음' : '없음' }  주차:${_result[index]['parking']}대',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                // ${_result[index]['salesprice'] > 0 ? (_result[index]['salesprice'] / 10000).round() : ''}
                              ],
                            ),
                            // child: ListTile(
                            //   title: Text(_result[index]['sub_addr']),
                            //   key: Key('marker_${index + 1}'),
                            //   subtitle: Text(
                            //       '매:${(_result[index]['salesprice'] / 10000).round()} 보:${(_result[index]['deposit'] / 10000).round()}/${(_result[index]['monthly'] / 10000).round()} ${_result[index]['size']}평 ${_result[index]['floor']}층'),
                            //   onLongPress: () {
                            //     Get.offAll(
                            //       CommDetailViewScreen(
                            //         id: _result[index]['id'],
                            //       ),
                            //     );
                            //   },
                            //   onTap: () {
                            //     _mapController.animateCamera(
                            //       CameraUpdate.newCameraPosition(
                            //         CameraPosition(
                            //           target: LatLng((_result[index]['lat'] / 1.0),
                            //               (_result[index]['lng'] / 1.0)),
                            //           zoom: 17,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng((_result[index]['lat'] / 1.0),
                                (_result[index]['lng'] / 1.0)),
                            zoom: 17,
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ),
          ],
        ),
        _searchForm(),
      ],
    );
  }


  Widget _androidMap() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: GoogleMap(
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference(1, 20),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(_lat, _lng),
              zoom: 18,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: Set.from(_markers),
          ),
        ),
        // Expanded(
        //   child: Container(
        //     child: ListView.builder(
        //       itemCount: snapshot.data!.length,
        //       controller: _listController,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: Text(snapshot.data![index]['sub_addr']),
        //           key: Key('marker_${index + 1}'),
        //           subtitle: Text(
        //               '${(snapshot.data![index]['deposit'] / 10000).round()}/${(snapshot.data![index]['monthly'] / 10000).round()} ${snapshot.data![index]['size']}평'),
        //           onLongPress: () {
        //             Get.offAll(
        //               CommDetailViewScreen(
        //                 id: snapshot.data![index]['id'],
        //               ),
        //             );
        //           },
        //           onTap: () {
        //             _mapController.animateCamera(
        //               CameraUpdate.newCameraPosition(
        //                 CameraPosition(
        //                   target: LatLng((snapshot.data![index]['lat'] / 1.0),
        //                       (snapshot.data![index]['lng'] / 1.0)),
        //                   zoom: 17,
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _searchForm() {


    return  Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('종류 : '),
                  DropdownButton(
                    value: _type,
                    onChanged: (value) {
                      _type = value.toString();
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('주거'),
                        value: 'H',
                      ),
                      DropdownMenuItem(
                        child: Text('상가/사무실'),
                        value: 'C',
                      ),
                    ],
                  ),
                  Text('층 : '),
                  DropdownButton(
                    value: _floor,
                    onChanged: (value) {
                      _floor = value.toString();
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('무관'),
                        value: '0',
                      ),            DropdownMenuItem(
                        child: Text('1층'),
                        value: '1',
                      ),            DropdownMenuItem(
                        child: Text('1-2층'),
                        value: '2',
                      ),
                      DropdownMenuItem(
                        child: Text('2층 이상'),
                        value: '3',
                      ),
                    ],
                  ),
                  Text('평수 : '),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      controller: _size,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if(value!.isEmpty) {
                          formData['size'] = '0';
                        } else {
                          formData['size'] = value!;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '검색 기준 넓이를 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _deposit.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  Text('검색어 : '),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text('매매 : '),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextFormField(
                      controller: _salesprice,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if(value!.isEmpty) {
                          formData['price'] = '0';
                        } else {
                          formData['price'] = value!;
                        }
                      },
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'ko',
                          decimalDigits: 0,
                          symbol: '₩',
                        )
                      ],
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '매매 기준 가격을 입력 하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _salesprice.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  Text('보증금 : '),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextFormField(
                      controller: _deposit,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if(value!.isEmpty) {
                          formData['deposit'] = '0';
                        } else {
                          formData['deposit'] = value!;
                        }
                      },
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'ko',
                          decimalDigits: 0,
                          symbol: '₩',
                        )
                      ],
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '보증금 기준 가격을 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _deposit.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  Text('월세 : '),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextFormField(
                      controller: _monthly,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if(value!.isEmpty) {
                          formData['monthly'] = '0';
                        } else {
                          formData['monthly'] = value!;
                        }
                      },
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'ko',
                          decimalDigits: 0,
                          symbol: '₩',
                        )
                      ],
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintText: '월세 기준 가격을 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _monthly.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(formData);
                        }
                        _search(
                            _searchController.text,
                            _type,
                            _floor,
                            formData['size'] == null ? '0' : formData['size']!.replaceAll('₩', '').replaceAll(',', ''),
                            formData['price'] == null ? '0' : formData['price']!.replaceAll('₩', '').replaceAll(',', ''),
                            formData['deposit'] == null ? '0' : formData['deposit']!.replaceAll('₩', '').replaceAll(',', ''),
                            formData['monthly'] == null ? '0' : formData['monthly']!.replaceAll('₩', '').replaceAll(',', '')
                        );
                      },
                      child: Text('검색')
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search(
      String _searchtxt,
      String _type,
      String _floor,
      String _size,
      String _salesprice,
      String _deposit,
      String _monthly,
      ) async {
    _result = [];
    final dio = Dio();

    final response = await dio.post('$appServerURL/mapselected', data: {
      'gubun': _type,
      'size': _size,
      'floor': _floor,
      'price': _salesprice,
      'deposit': _deposit,
      'monthly': _monthly,
      'callname': _searchtxt,
    });

    if (response.data.length > 0) {
      _result = response.data;
      _markers.clear();
      for (int i = 0; i < response.data.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('marker_${i + 1}'),
            position: LatLng((response.data[i]['lat'] / 1.0),
                (response.data[i]['lng'] / 1.0)),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              onTap: () {
                print('marker_${i + 1} clicked');
                Get.offAll(
                  CommDetailViewScreen(
                    id: response.data[i]['id'],
                  ),
                );
              },
              title: response.data[i]['sub_addr'],
              snippet:
              '${(response.data[i]['deposit'] / 10000).round()}/${(response.data[i]['monthly'] / 10000).round()} ${response.data[i]['size']}평',
            ),
            onTap: () {
              // _listController.animateTo(
              //   i * 100.0,
              //   duration: const Duration(milliseconds: 900),
              //   curve: Curves.fastOutSlowIn,
              // );
              _listController.jumpTo(i * 96.0);
            },

            //   print('marker_${i + 1} clicked');
            //   getx.Get.to(
            //     CommDetailViewScreen(
            //       id: response2.data[i]['id'],
            //     ),);
            // },
          ),
        );
      }
    }

    dio.close();

    _mapController.reactive();
    setState(() {
      _markers = _markers;
    });
  }
}
