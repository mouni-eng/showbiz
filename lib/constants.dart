import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyerdeal/models/user_model.dart';
import 'package:flyerdeal/size_config.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: Colors.redAccent,
    primaryColorLight: const Color(0xFF6e07f3),
    primaryColorDark: const Color(0xFF333333),
    hintColor: const Color(0xFF828282),
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    ));

ThemeData darkTheme = ThemeData(
    primaryColor: Colors.redAccent,
    primaryColorLight: const Color(0xFF6e07f3),
    primaryColorDark: const Color(0xFFCBE4DE),
    hintColor: const Color(0xFFCBE4DE),
    backgroundColor: const Color(0xFF2E4F4F),
    scaffoldBackgroundColor: const Color(0xFF2C3333),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    ));

BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.06), //color of shadow
  //spread radius
  blurRadius: width(30), // blur radius
  offset: const Offset(0, 4),
);

BoxShadow boxShadowNav = BoxShadow(
  color: Colors.black.withOpacity(0.06), //color of shadow
  //spread radius
  blurRadius: width(30), // blur radius
  offset: const Offset(0, 4),
);

EdgeInsets padding = EdgeInsets.symmetric(
  horizontal: width(16),
  vertical: height(16),
);

const loading = Center(
  child: CircularProgressIndicator.adaptive(),
);

UserModel? userModel;

const String errorMessage = "Something went wrong!";
const String formMessage = "Complete Form Data";
const String title = "title";
const String subtitle = "subTitle";
const String notifyTable = "notifyTable";
const userRef = "users";
const flyerRef = "flyers";
const storeRef = "stores";
const favRef = "flyersWishList";
const storeFav = "storesWishList";
const categoryRef = "categories";
