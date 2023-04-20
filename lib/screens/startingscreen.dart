import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/commercialscreen.dart';
import 'package:kakao_login_test/screens/registrationscreen.dart';
import 'package:kakao_login_test/screens/residentialscreen.dart';

import '../status/controller.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;
    final controller = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('스마일 부동산 물건 관리'),
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
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx((){ // Obx 사용 시 따로 Controller 명시 X 보여줄 위젯만. 근데 Get.put을 반드시 사용
              return Text(
                '${controller.userName.value}님 환영합니다.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ResidentialScreen());
                    },
                    child: Text(
                        '주거용 부동산',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                     ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to (() => CommecialScreen());
                    },
                    child: const Text('상업용 부동산',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to (() => RegistrationScreen());
                    },
                    child: const Text('신규 물건 등록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
