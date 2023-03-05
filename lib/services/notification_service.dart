import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flyerdeal/view_models/notification_cubit/cubit.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();

  static final instance = FirebaseMessagingService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void configure({required NotificationCubit notificationCubit}) {
    FirebaseMessaging.onMessage.listen((message) {
      // Handle message when app is in foreground
      print(message.toString());
      notificationCubit.loadNotifications([message]);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Handle message when app is in background
      notificationCubit.loadNotifications([message]);
    });
  }
}
