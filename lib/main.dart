import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_login_test/common/commondata.dart';
import 'package:kakao_login_test/screens/main_screen.dart';
import './common/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '45ce62ef8ac5361d8994f2a9ca50a1ed');
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor)
      ),
      themeMode: ThemeMode.system ,
      home: LoginSignupScreen(),
    );
  }
}


