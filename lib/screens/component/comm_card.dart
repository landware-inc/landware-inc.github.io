import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kakao_login_test/screens/commdetailview.dart';

import '../../common/commondata.dart';
import '../assetdetailview.dart';


class CommCard extends StatelessWidget {
  final int id;
  final Widget image;
  final String division;
  final int price;
  final int price2;
  final String eliv;
  final String parking;
  final int size;
  final int entitleprice;
  final String indate;
  final String floor;
  final String type;
  final String addr;

  const CommCard({
    required this.price,
    required this.price2,
    required this.id,
    required this.image,
    required this.division,
    required this.entitleprice,
    required this.floor,
    required this.indate,
    required this.parking,
    required this.eliv,
    required this.size,
    required this.type,
    required this.addr,
    Key? key}) : super(key: key);


  updateLatLng() async {
    final dio = Dio();
    double _lat = 0.0;
    double _lng = 0.0;

    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$addr&key=$googleMapKey&language=ko';

    final responseGps = await dio.get(gpsUrl);

    var rst = jsonDecode(responseGps.toString());

    _lat = rst['results'][0]['geometry']['location']['lat'];
    _lng = rst['results'][0]['geometry']['location']['lng'];
    // print(response.data[0]['addr']);
    // print ('========================================');
    // print(_lat.toString());
    // print('========================================');


    try {
      final response = await dio.post(
          '$appServerURL/updatelatlng',
          data: {
            'id': id,
            'lat': _lat,
            'lng': _lng,
          }
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');

//    updateLatLng();

    return GestureDetector(
      onTap: () {
        Get.to(() => CommDetailViewScreen(
          id: id,
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                height: 95,
                width: 95,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: image,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$division',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                            ),
                            Text(
                              '$size 평',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryContainer
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              if (price2 != 0)
                                Text(
                                  '${f.format(int.parse(price.toString()))}만원 / ${f.format(int.parse(price2.toString()))}만원',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                  ),
                                ),
                              if (price2 == 0)
                                Text(
                                  '${f.format(int.parse(price.toString()))}만원',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '$type',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '엘리베이터 : ${eliv == "1" ? "O" : "X"} / 주차 : ${(parking == "") ? "0" : parking}대',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                            ),
                            Text(
                              '$floor 층',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                            ),
                            ]
                      ),
                      if(entitleprice > 0)
                        Text(
                          '권리금 : ${f.format(int.parse(entitleprice.toString()))}만원',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
