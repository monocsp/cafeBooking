abstract class SocialLogin {
  ///로그인 시 사용
  Future<bool> login();

  ///로그아웃 시 사용
  Future<bool> logout();

  Future<dynamic> getLoginInfo();
}
