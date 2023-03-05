import 'dart:io';

import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/language_model.dart';
import 'package:flyerdeal/services/auth_service.dart';
import 'package:flyerdeal/services/language_service.dart';
import 'package:flyerdeal/services/local/cache_helper.dart';
import 'package:flyerdeal/view_models/profile_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileStates());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();

  bool isNotify = false;
  bool isDarkMode = false;
  File? profileImage;
  String language = "";

  ThemeData theme = lightTheme;

  chooseProfileImage(File file) async {
    profileImage = file;
    emit(OnChangeState());
  }

  Future<void> getUserData() async {
    emit(GetProfileLoadingState());
    _authService.getUser().then(
      (value) {
        emit(GetProfileSuccessState());
      },
    ).catchError((error) {
      print((error.toString()));
      emit(GetProfileErrorState());
    });
  }

  onChangeNotify() {
    isNotify = !isNotify;
    emit(OnChangeState());
  }

  onChangeDarkMode() {
    isDarkMode = !isDarkMode;
    emit(OnChangeState());
    if (isDarkMode) {
      theme = darkTheme;
      emit(OnChangeState());
    } else {
      theme = lightTheme;
      emit(OnChangeState());
    }
  }

  switchLanguage(final String lang) async {
    language = lang;
    emit(OnChangeState());
    await setLocale(language);
  }

  logout() {
    /*_authService.logout().then((value) {
      emit(LoggedOutState(userDetails!.role!));
      userDetails = null;
    });*/
  }
}
