import 'package:cafe_booking/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

class FCMController extends GetxService {
  static FCMController get to => Get.find();
  // late AndroidNotificationChannel channel;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // String? _lastConsumedMessageId;

  @override
  void onInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //Foreground
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   description: 'This channel is used for important notifications.', // description
    //   importance: Importance.high,
    // );

    // //For FCM Foreground Listen.
    // //ForeGround일 경우에 작동하는 함수
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;

    //   if (notification == null) return;

    //   Map<String, dynamic> _payload = Map<String, dynamic>.from(message.data)
    //     ..addAll({"body": "${message.notification?.body}"});
    //   String _payloadString = jsonEncode(_payload);

    //   FcmPushData fcmPushData = FcmPushData.fromPaylad(_payloadString);
    //   //dialog open
    //   fcmPushData.openDialog();
    // });

    // //App state pause일 때 FCM 호출됨
    // FirebaseMessaging.onMessageOpenedApp.listen(((message) => _handleMessage(message)));

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    //App State : Terminated일때 FCM 알림이 오는 경우
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();

    // if (initialMessage != null) {
    //   if (_messageAlreadyConsumed(initialMessage.messageId)) return;
    //   Map<String, dynamic> _payload =
    //       Map<String, dynamic>.from(initialMessage.data);
    //   String _payloadString = jsonEncode(_payload);

    //   FcmPushData fcmPushData = FcmPushData.fromPaylad(_payloadString);
    //   fcmPushData.openDialog();
    // }
  }

  // Future<void> _handleMessage(RemoteMessage message) async {
  //   if (_messageAlreadyConsumed(message.messageId)) return;
  //   log("Show Dialog");
  //   Map<String, dynamic> _payload = Map<String, dynamic>.from(message.data)
  //     ..addAll({"body": "${message.notification?.body}"});

  //   String _payloadString = jsonEncode(_payload);
  //   log("_handleMessage : $_payloadString");

  //   FcmPushData fcmPushData = FcmPushData.fromPaylad(_payloadString);

  //   fcmPushData.openDialog();
  // }

  // //동일한 FCM은 호출되지 않음
  // bool _messageAlreadyConsumed(String? newMessageId) {
  //   if (_lastConsumedMessageId == newMessageId) {
  //     return true;
  //   }

  //   _lastConsumedMessageId = newMessageId;
  //   return false;
  // }
}
