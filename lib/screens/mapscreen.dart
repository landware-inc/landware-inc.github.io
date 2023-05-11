import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

    final response2 = await dio.post(
        '$appServerURL/nearlist',
        data: {
          'id': 1,
          'lat': _lat,
          'lng': _lng,
          'type': 'C',
        }
    );

    if(response2.data.length > 0) {
      for(int i = 0; i < response2.data.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('marker_${i + 1}'),
            position: LatLng((response2.data[i]['lat']/1.0), (response2.data[i]['lng']/1.0)),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              onTap: () {
                print('marker_${i + 1} clicked');
                Get.offAll(
                  CommDetailViewScreen(
                    id: response2.data[i]['id'],
                  ),);
              },
              title: response2.data[i]['sub_addr'],
              snippet: '${(response2.data[i]['deposit']/10000).round()}/${(response2.data[i]['monthly']/10000).round()} ${response2.data[i]['size']}평',
            ),
              onTap: () {
                // _listController.animateTo(
                //   i * 100.0,
                //   duration: const Duration(milliseconds: 900),
                //   curve: Curves.fastOutSlowIn,
                // );
                _listController.jumpTo(i*110.0);
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
  Widget build(BuildContext context)  {


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
      body:FutureBuilder(
        future: pagenationMapData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                        subtitle: Text('${(snapshot.data![index]['deposit']/10000).round()}/${(snapshot.data![index]['monthly']/10000).round()} ${snapshot.data![index]['size']}평'),
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
                                target: LatLng((snapshot.data![index]['lat']/1.0), (snapshot.data![index]['lng']/1.0)),
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
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}
