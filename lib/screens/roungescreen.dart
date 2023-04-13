import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/listview.dart';

import '../common/commondata.dart';
import '../status/controller.dart';

class RoungeScreen extends StatefulWidget {
  const RoungeScreen({Key? key}) : super(key: key);

  @override
  State<RoungeScreen> createState() => _RoungeScreenState();
}

class _RoungeScreenState extends State<RoungeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedInUser;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rounge'),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ID : ${controller.userId.value}'),
            Text('Email : ${controller.userEmail.value}'),
            Text('Name : ${controller.userName.value}'),
            Text('Rounge'),
            GetBuilder<Controller>(
              init: Controller(), // init을 설정하지 않을 시 에러 발생
              builder: (_) => Text(
                'clicks: ${_.count1}',
              ),
            ),
            TextButton(
                onPressed: controller.increment1,
                child: const Text('increment1')),
            GetX<Controller>( // init을 통해 Controller를 등록할 수 있지만 여기선 Get.put을 사용
              builder: (_) => Text(
                'clicks: ${_.count2.value}',
              ),
            ),
            Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              return Text(
                'clicks: ${controller.count2.value}',
              );
            }),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
                onPressed: (){
                  Get.to(() => ListViewScreen());
                },
                child: const Text('List Test 화면으로')),
            Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              return Text(
                '${controller.userName.value}',
              );
            }),
          ],
        ),
      ),
    );
  }
}
