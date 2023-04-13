import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class listViewScreen extends StatelessWidget {
  const listViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();


    return Container(
      child: Text('listViewScreen'),
    );
  }
}
