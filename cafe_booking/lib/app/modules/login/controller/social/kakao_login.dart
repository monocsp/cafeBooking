import 'dart:developer';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'abstract_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    //한번 로그인해서 토큰값이 존재한다면.
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        log('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        return true;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          log('토큰 만료 $error');
        } else {
          log('토큰 정보 조회 실패 $error');
        }

        try {
          // 카카오 계정으로 로그인
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          log('로그인 성공 ${token.accessToken}');
          return true;
        } catch (error) {
          log('로그인 실패 $error');
          return false;
        }
      }
    } else {
      try {
        //카카오가 설치가 되어있다면
        bool isInstalled = await isKakaoTalkInstalled();
        if (isInstalled) {
          try {
            //카카오톡으로 로그인
            await UserApi.instance.loginWithKakaoTalk();
            return true;
          } catch (e) {
            return false;
          }
        } else {
          try {
            //설치가 안 되어있다면
            //카카오톡 계정으로 로그인
            var token = await UserApi.instance.loginWithKakaoAccount();
            log("TOKEN : $token");
            return true;
          } catch (e) {
            return false;
          }
        }
      } catch (e) {
        return false;
      }
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future getLoginInfo() async {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      log('토큰 정보 보기 성공'
          '\n회원정보: ${tokenInfo.id}'
          '\n만료시간: ${tokenInfo.expiresIn} 초');
      return tokenInfo.id;
    } catch (error) {
      log('토큰 정보 보기 실패 $error');
      return false;
    }
  }
}
