import 'package:http/http.dart' as http;

///Firebase function url
///kakao, naver에서 로그인 시 사용
String customTokenUrl =
    'https://us-central1-cafebooking-9a2cd.cloudfunctions.net/createCustomToken';

String kakaoNativeAppKey = "a02190e545741ae61daa0d059ddb9529";

///kakao 로그인 시 사용되는 token데이터
Future<String> createCustomToken(
  Map<String, dynamic> user,
) async {
  final customTokenResponse = await http.post(Uri.parse(customTokenUrl), body: user);

  return customTokenResponse.body;
}
