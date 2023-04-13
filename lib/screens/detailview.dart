import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/commondata.dart';

class DetailViewScreen extends StatelessWidget {
  final int id;
  const DetailViewScreen({
    required this.id,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
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
      body: Container(),
    );
  }

  getDetailData() async {
    final dio = Dio();
    final response = await dio.post(
        '$appServerURL/getusrname',
        data: {
          'id': id,
        }
    );
    print(response.data);
    dio.close();
  }
}
