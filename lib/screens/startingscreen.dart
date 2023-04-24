import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_login_test/screens/commercialscreen.dart';
import 'package:kakao_login_test/screens/homebasketlist.dart';
import 'package:kakao_login_test/screens/registrationscreen.dart';
import 'package:kakao_login_test/screens/residentialscreen.dart';

import '../common/commondata.dart';
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
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      final dio = Dio();
                      final response = await dio.get('$appServerURL/regi_maxvalue');

                      controller.maxS(response.data[0]['maxs']);
                      controller.maxPrice(response.data[0]['maxs']);
                      controller.maxJ(response.data[0]['maxj']);
                      controller.maxJeonse(response.data[0]['maxj']);
                      controller.maxM(response.data[0]['maxm']);
                      controller.maxMonthly(response.data[0]['maxm']);
                      controller.maxD(response.data[0]['maxd']);
                      controller.maxDeposit(response.data[0]['maxd']);
                      controller.minS(response.data[0]['mins']);
                      controller.minPrice(response.data[0]['mins']);
                      controller.minJ(response.data[0]['minj']);
                      controller.minJeonse(response.data[0]['minj']);
                      controller.minM(response.data[0]['minm']);
                      controller.minMonthly(response.data[0]['minm']);
                      controller.minD(response.data[0]['mind']);
                      controller.minDeposit(response.data[0]['mind']);
                      controller.selectGubun('전세');
                      controller.minSize(response.data[0]['minz']);
                      controller.minZ(response.data[0]['minz']);
                      controller.maxSize(response.data[0]['maxz']);
                      controller.maxZ(response.data[0]['maxz']);

                      dio.close();

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
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      final dio = Dio();
                      final response = await dio.get('$appServerURL/comm_maxvalue');

                      controller.maxS(response.data[0]['maxs']);
                      controller.maxPrice(response.data[0]['maxs']);
                      controller.maxE(response.data[0]['maxe']);
                      controller.maxEntitle(response.data[0]['maxe']);
                      controller.maxM(response.data[0]['maxm']);
                      controller.maxMonthly(response.data[0]['maxm']);
                      controller.maxD(response.data[0]['maxd']);
                      controller.maxDeposit(response.data[0]['maxd']);
                      controller.minS(response.data[0]['mins']);
                      controller.minPrice(response.data[0]['mins']);
                      controller.minE(response.data[0]['mine']);
                      controller.minEntitle(response.data[0]['mine']);
                      controller.minM(response.data[0]['minm']);
                      controller.minMonthly(response.data[0]['minm']);
                      controller.minD(response.data[0]['mind']);
                      controller.minDeposit(response.data[0]['mind']);
                      controller.selectGubun('전세');
                      controller.minSize(response.data[0]['minz']);
                      controller.minZ(response.data[0]['minz']);
                      controller.maxSize(response.data[0]['maxz']);
                      controller.maxZ(response.data[0]['maxz']);

                      dio.close();
                      Get.to (() => CommercialScreen());
                    },
                    child: const Text('상업용 부동산',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Get.to (() => HomeBasketListViewScreen());
                    },
                    child: const Text('관심 물건 보기',
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
