
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kakao_login_test/screens/commercialscreen.dart';
import 'package:kakao_login_test/screens/homebasketlist.dart';
import 'package:kakao_login_test/screens/registrationscreen.dart';
import 'package:kakao_login_test/screens/residentialscreen.dart';
import 'package:kakao_login_test/screens/startingscreen.dart';
import 'package:kakao_login_test/status/controller.dart';

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
      onTap: (index) {
        if (index == 0) {
          Get.to(() => const StartScreen());
        } else if (index == 1) {
          Get.to(() => const ResidentialScreen());
        }  else if (index == 2) {
          Get.to(() => const CommercialScreen());
        } else if (index == 3) {
          Get.to(() => const HomeBasketListViewScreen());
        } else if (index == 4) {
          Get.to(() => const RegistrationScreen());
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
      ],
    );
  }
}
