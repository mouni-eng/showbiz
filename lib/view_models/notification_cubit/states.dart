import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<RemoteMessage> messages;

  NotificationLoaded(this.messages);
}