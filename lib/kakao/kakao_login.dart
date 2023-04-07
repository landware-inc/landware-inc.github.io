import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_login_test/kakao/social_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오 톡으로 로그인 성공');
        } catch (e) {
          print('카카오 톡으로 로그인 실패 : $e');
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오 계정으로 로그인 성공');
        } catch (e) {
          print('카카오 계정으로 로그인 실패 : $e');
          return false;
        }
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
