import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';
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
const userRef = "users";
const flyerRef = "flyers";
const storeRef = "stores";
const favRef = "wishList";
const categoryRef = "categories";
const bookingRef = "bookings";

FlyerModel flyerModel = FlyerModel(
  name: "Peavy Mart Flyers",
  category: "Electronics",
  image:
      "https://static.shopping-canada.com/staples-deal-of-the-week-on-from-february-19-to-february-25-2020-page-10.jpg",
  store: storeModel,
  from: DateTime.now(),
  to: DateTime.now().add(
    const Duration(
      days: 20,
    ),
  ),
  flyerPdf: '',
);

StoreModel storeModel = StoreModel(
  name: "Peavy Mart",
  category: "Electronics",
  website: "https://www.peaveymart.com/",
  image:
      "https://th.bing.com/th/id/R.323212658da45fa6a96f1f6552109916?rik=SBx9Ti35cVTxlA&riu=http%3a%2f%2fshopblackfriday.ca%2fwp-content%2fuploads%2f2014%2f11%2fpeaveymart.png&ehk=X9TI8ve0wqnooV8gG%2bpJLS%2b84HvpIIY7p9ktw8%2fDYQQ%3d&risl=&pid=ImgRaw&r=0",
);
