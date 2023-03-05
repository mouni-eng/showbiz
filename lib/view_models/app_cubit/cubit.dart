import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyerdeal/services/auth_service.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/view_models/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();

  Locale locale = const Locale(ENGLISH, '');

  getCurrentLocale() {
    emit(GetLocaleLoadingState());
    getLocale().then((value) {
      locale = value;
      emit(GetLocaleSuccessState());
    }).then((value) {
      getUserData();
    }).catchError((error) {
      emit(GetLocaleErrorState());
    });
  }

  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    _authService.getUser().then(
      (value) {
        emit(GetUserSuccessState());
      },
    ).catchError((error) {
      print((error.toString()));
      emit(GetUserErrorState());
    });
  }
}
