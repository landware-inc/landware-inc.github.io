import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../assetdetailview.dart';


class AssetCard extends StatelessWidget {
  final int id;
  final Widget image;
  final String callname;
  final int price;
  final int price2;
  final int room;
  final int bath;
  final String sizetype;
  final String direction;
  final String indate;
  final String floor;
  final String type;

  const AssetCard({
    required this.price,
    required this.price2,
    required this.id,
    required this.image,
    required this.callname,
    required this.direction,
    required this.floor,
    required this.indate,
    required this.bath,
    required this.room,
    required this.sizetype,
    required this.type,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');

    return GestureDetector(
      onTap: () {
        Get.to(() => AssetDetailViewScreen(
          id: id,
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                              '$callname',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                            ),
                            Text(
                              '$sizetype',
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
                            '방$room/욕실$bath',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          Text(
                            '$direction향',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          Text(
                            '$floor (층/총층)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),]
                      ),

                      Text(
                        '입주가능일 : $indate',
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
