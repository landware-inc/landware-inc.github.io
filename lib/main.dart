import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_login_test/kakao/login_screen.dart';

void main()  {

  KakaoSdk.init(nativeAppKey: '45ce62ef8ac5361d8994f2a9ca50a1ed');


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}


