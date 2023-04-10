import 'package:flutter/material.dart';


class AssetCard extends StatelessWidget {
  final int id;
  final Widget image;
  final String callname;
  final int price;
  final int room;
  final int bath;
  final String sizetype;
  final String direction;
  final String indate;
  final String floor;

  const AssetCard({
    required this.price,
    required this.id,
    required this.image,
    required this.callname,
    required this.direction,
    required this.floor,
    required this.indate,
    required this.bath,
    required this.room,
    required this.sizetype,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$callname',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$sizetype타입',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$price만원',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '방$room / 욕실$bath',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$direction향',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$floor (층/총층)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),]
        ),
        const SizedBox(height: 8,),
        Row (
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
              Text(
                '입주가능일 : $indate',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ]
        ),
      ],
    );
  }
}
