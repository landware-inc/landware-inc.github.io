import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kakao_login_test/common/commondata.dart';


class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  @override
  Widget build(BuildContext context) {
    getAddr();

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(35.1665603802915, 129.1787687802915),
            zoom: 17,
        ),
      ),
    );
  }

  void getAddr() async {
    final dio = Dio();

    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=해운대구 양운로 37번길 11 106동&key=$googleMapKey&language=ko';

    final responseGps = await dio.get(gpsUrl);

    var rst = jsonDecode(responseGps.toString());

    print(rst['results'][0]['geometry']['location']['lat'].toString());

    dio.close();
  }
}

