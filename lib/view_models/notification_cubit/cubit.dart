import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flyerdeal/view_models/notification_cubit/states.dart';
import 'package:meta/meta.dart';


class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void loadNotifications(List<RemoteMessage> messages) {
    emit(NotificationLoaded(messages));
  }
}
