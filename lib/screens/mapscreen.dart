import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_login_test/screens/commdetailview.dart';
import 'package:kakao_login_test/screens/component/bottom_menu.dart';

import '../common/commondata.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final _listController = ScrollController();
  final _searchController = TextEditingController();
  String _floor = '0';
  String _type = 'C';
  final _size = TextEditingController();
  final _deposit = TextEditingController();
  final _monthly = TextEditingController();
  final _salesprice = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Marker> _markers = [];
  double _lat = 35.1645654;
  double _lng = 129.1774185;

  Future<List> pagenationMapData() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    _lat = position.latitude;
    _lng = position.longitude;

    final dio = Dio();

    final response2 = await dio.post('$appServerURL/nearlist', data: {
      'id': 1,
      'lat': _lat,
      'lng': _lng,
      'type': 'C',
    });

    if (response2.data.length > 0) {
      for (int i = 0; i < response2.data.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('marker_${i + 1}'),
            position: LatLng((response2.data[i]['lat'] / 1.0),
                (response2.data[i]['lng'] / 1.0)),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              onTap: () {
                print('marker_${i + 1} clicked');
                Get.offAll(
                  CommDetailViewScreen(
                    id: response2.data[i]['id'],
                  ),
                );
              },
              title: response2.data[i]['sub_addr'],
              snippet:
                  '${(response2.data[i]['deposit'] / 10000).round()}/${(response2.data[i]['monthly'] / 10000).round()} ${response2.data[i]['size']}평',
            ),
            onTap: () {
              // _listController.animateTo(
              //   i * 100.0,
              //   duration: const Duration(milliseconds: 900),
              //   curve: Curves.fastOutSlowIn,
              // );
              _listController.jumpTo(i * 110.0);
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
    return response2.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('지도 보기'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const MapScreen());
            },
            icon: const Icon(Icons.map),
          ),
        ],
      ),
      body: FutureBuilder(
          future: pagenationMapData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(kIsWeb)
              return _webMap(snapshot);
            else
              return _androidMap(snapshot);
          }),
      bottomNavigationBar: BottomMenuBar(),
    );
  }


  Widget _webMap(snapshot) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                controller: _listController,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['sub_addr']),
                    key: Key('marker_${index + 1}'),
                    subtitle: Text(
                        '${(snapshot.data![index]['deposit'] / 10000).round()}/${(snapshot.data![index]['monthly'] / 10000).round()} ${snapshot.data![index]['size']}평'),
                    onLongPress: () {
                      Get.offAll(
                        CommDetailViewScreen(
                          id: snapshot.data![index]['id'],
                        ),
                      );
                    },
                    onTap: () {
                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng((snapshot.data![index]['lat'] / 1.0),
                                (snapshot.data![index]['lng'] / 1.0)),
                            zoom: 17,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('종류 : '),
                DropdownButton(
                  value: _type,
                  onChanged: (value) {
                    setState(() {
                      _type = value.toString();
                    });
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
                Text('검색어 : '),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextField(
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
                Text('매매 : '),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextField(
                    controller: _salesprice,
                    inputFormatters: [CurrencyTextInputFormatter(
                      locale: 'ko_KR',
                      decimalDigits: 0,
                      symbol: '',
                    )],
                    keyboardType: TextInputType.number,
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
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextField(
                    controller: _deposit,
                    inputFormatters: [CurrencyTextInputFormatter(
                      locale: 'ko_KR',
                      decimalDigits: 0,
                      symbol: '',
                    )],
                    keyboardType: TextInputType.number,
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
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: TextField(
                    controller: _monthly,
                    inputFormatters: [CurrencyTextInputFormatter(
                      locale: 'ko_KR',
                      decimalDigits: 0,
                      symbol: '',
                    )],
                    keyboardType: TextInputType.number,
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
                Text('층 : '),
                DropdownButton(
                  value: _floor,
                  onChanged: (value) {
                    setState(() {
                      _floor = value.toString();
                    });
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
                ElevatedButton(
                    onPressed: (){},
                    child: Text('검색')
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _androidMap(snapshot) {
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
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              controller: _listController,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['sub_addr']),
                  key: Key('marker_${index + 1}'),
                  subtitle: Text(
                      '${(snapshot.data![index]['deposit'] / 10000).round()}/${(snapshot.data![index]['monthly'] / 10000).round()} ${snapshot.data![index]['size']}평'),
                  onLongPress: () {
                    Get.offAll(
                      CommDetailViewScreen(
                        id: snapshot.data![index]['id'],
                      ),
                    );
                  },
                  onTap: () {
                    _mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng((snapshot.data![index]['lat'] / 1.0),
                              (snapshot.data![index]['lng'] / 1.0)),
                          zoom: 17,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
