import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'component/asset_card.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();


    return Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AssetCard(
              id: 1,
              direction: '남동',
              callname: '리츠캐슬',
              room: 3,
              bath: 2,
              sizetype: '26C',
              price: 23000,
              floor: '15/25',
              indate: '5월말 이후',
              image: Image.network(
                'https://lh3.googleusercontent.com/ZcLmUHj2ik_2ybVZPeefkHtHcGSN6YhCFX3t4aG5QyRkYdfrRXgbCJUJ3O2ugxg=w600',
                fit: BoxFit.cover,
              ),
            ),
          ),
      ),
    );
  }
}
