import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/infrastructure/exceptions.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

enum SnackbarType { success, warning, error }

class ErrorService {
  static String defineError(error) {
    if (error is ApiException) {
      return error.errorCode;
    } else if (error is String) {
      return error;
    }
    return '';
  }
}

class AlertService {
  static showSnackbarAlert(String strAlert, SnackbarType type, context) {
    Flushbar(
      padding: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width(16),
        vertical: height(16),
      ),
      boxShadows: [boxShadow],
      borderRadius: BorderRadius.circular(16),
      backgroundColor: Theme.of(context).backgroundColor,
      titleText: type.index == 2
          ? CustomText(
              fontSize: width(16),
              text: strAlert,
              fontWeight: FontWeight.w600,
            )
          : CustomText(
              fontSize: width(16),
              text: type.name,
              fontWeight: FontWeight.w600,
            ),
      messageText: CustomText(
        color: Theme.of(context).hintColor,
        fontSize: width(14),
        maxlines: 3,
        text: strAlert,
      ),
      icon: SvgPicture.asset("assets/images/${type.name}.svg"),
      mainButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(16),
          ),
          child: SvgPicture.asset("assets/images/exit.svg"),
        ),
      ),
    ).show(context);
  }
}
