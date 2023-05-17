
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kakao_login_test/screens/commercialscreen.dart';
import 'package:kakao_login_test/screens/homebasketlist.dart';
import 'package:kakao_login_test/screens/mapscreen.dart';
import 'package:kakao_login_test/screens/registrationscreen.dart';
import 'package:kakao_login_test/screens/residentialscreen.dart';
import 'package:kakao_login_test/screens/startingscreen.dart';
import 'package:kakao_login_test/status/controller.dart';

import '../../common/commondata.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({Key? key}) : super(key: key);

  @override
  State<BottomMenuBar> createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: (index) async {
        if (index == 0) {
          Get.to(() => const StartScreen());
        } else if (index == 1) {
          final dio = Dio();
          final response = await dio.get('$appServerURL/regi_maxvalue');

          controller.maxS(response.data[0]['maxs'].round());
          controller.maxPrice(response.data[0]['maxs'].round());
          controller.maxJ(response.data[0]['maxj'].round());
          controller.maxJeonse(response.data[0]['maxj'].round());
          controller.maxM(response.data[0]['maxm'].round());
          controller.maxMonthly(response.data[0]['maxm'].round());
          controller.maxD(response.data[0]['maxd'].round());
          controller.maxDeposit(response.data[0]['maxd'].round());
          controller.minS(response.data[0]['mins'].round());
          controller.minPrice(response.data[0]['mins'].round());
          controller.minJ(response.data[0]['minj'].round());
          controller.minJeonse(response.data[0]['minj'].round());
          controller.minM(response.data[0]['minm'].round());
          controller.minMonthly(response.data[0]['minm'].round());
          controller.minD(response.data[0]['mind']);
          controller.minDeposit(response.data[0]['mind'].round());
          controller.selectGubun('전세');
          controller.minSize(response.data[0]['minz'].round());
          controller.minZ(response.data[0]['minz'].round());
          controller.maxSize(response.data[0]['maxz'].round());
          controller.maxZ(response.data[0]['maxz'].round());

          dio.close();

          Get.to(() => const ResidentialScreen());
        }  else if (index == 2) {
          final dio = Dio();
          final response = await dio.get('$appServerURL/comm_maxvalue');

          controller.maxS(response.data[0]['maxs'].round());
          controller.maxPrice(response.data[0]['maxs'].round());
          controller.maxE(response.data[0]['maxe'].round());
          controller.maxEntitle(response.data[0]['maxe'].round());
          controller.maxM(response.data[0]['maxm'].round());
          controller.maxMonthly(response.data[0]['maxm'].round());
          controller.maxD(response.data[0]['maxd'].round());
          controller.maxDeposit(response.data[0]['maxd'].round());
          controller.minS(response.data[0]['mins'].round());
          controller.minPrice(response.data[0]['mins'].round());
          controller.minE(response.data[0]['mine'].round());
          controller.minEntitle(response.data[0]['mine'].round());
          controller.minM(response.data[0]['minm'].round());
          controller.minMonthly(response.data[0]['minm'].round());
          controller.minD(response.data[0]['mind'].round());
          controller.minDeposit(response.data[0]['mind'].round());
          controller.selectGubun('전세');
          controller.minSize(response.data[0]['minz'].round());
          controller.minZ(response.data[0]['minz'].round());
          controller.maxSize(response.data[0]['maxz'].round());
          controller.maxZ(response.data[0]['maxz'].round());

          dio.close();
          Get.to(() => const CommercialScreen());
        } else if (index == 3) {
          Get.to(() => const HomeBasketListViewScreen());
        } else if (index == 4) {
          Get.to(() => const RegistrationScreen());
        } else if (index == 5) {
          Get.to(() => const MapScreen());
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: '주거',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: '상업',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: '관심',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: '신규',
        ),
        if(kIsWeb)
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
      ],
    );
  }
}


