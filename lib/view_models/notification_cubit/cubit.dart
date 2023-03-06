import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/models/notification_model.dart';
import 'package:flyerdeal/services/local/notify_databse_helper.dart';
import 'package:flyerdeal/view_models/notification_cubit/states.dart';
import 'package:meta/meta.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

    static NotificationCubit get(context) => BlocProvider.of(context);


  List<NotificationModel> notifications = [];

  void loadNotifications() {
    emit(NotificationLoadingState());
    var db = NotificationDatbaseHelper.db;
    db.getAllNotification().then((value) {
      notifications = value;
      emit(NotificationSuccessState());
    }).catchError((error) {
      emit(NotificationErrorState());
    });
  }
}
