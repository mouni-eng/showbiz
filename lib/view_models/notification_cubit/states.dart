import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {}

class NotificationErrorState extends NotificationState {}