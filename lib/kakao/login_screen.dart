import 'package:flutter/material.dart';
import 'package:kakao_login_test/kakao/main_view_model.dart';

import 'kakao_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = MainViewModel(KakaoLogin());
//  String key = 'test_test';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
            viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ''),
        Text(
          viewModel.user?.kakaoAccount?.profile?.nickname ?? '',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text('${viewModel.isLogined ? '로그인됨' : '로그인안됨'}'),
        Text('id : ${viewModel.user?.id}'),
        Text('email : ${viewModel.user?.kakaoAccount?.email}'),
        Text('nickname : ${viewModel.user?.kakaoAccount?.profile?.nickname}'),
        ElevatedButton(
          onPressed: () async {
            // key = await KakaoSdk.origin;
            // print(key);
            if (viewModel.isLogined) {
              await viewModel.logout();
            } else {
              await viewModel.login();
            }
            setState(() {});
          },
          child: Text(viewModel.isLogined ? '로그아웃' : '로그인'),
        ),
      ],
    );
  }
}
