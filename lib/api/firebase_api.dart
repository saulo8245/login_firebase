import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

class FirebaseApi {
  // fire base messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  // notificaçao
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print('token: $fCMToken');

    initPushNotifications();
  }

  // receber mensagens
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
