enum LoginHiveEnum {
  openBox(openBoxName: 'BookCafe'),

  autoLogin(hiveKey: 'AutoLogin');

  final String openBoxName;
  final String hiveKey;
  const LoginHiveEnum({this.openBoxName = '', this.hiveKey = ''});
}
