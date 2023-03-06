import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyerdeal/infrastructure/exceptions.dart';
import 'package:flyerdeal/models/flyer_model.dart';
import 'package:flyerdeal/models/store_model.dart';

void printLn(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

class CheckUtil {
  static isFavourite(
      {required FlyerModel flyerModel, required List<FlyerModel> favourites}) {
    bool isFav = favourites.any((flyerToCheck) => flyerToCheck.id == flyerModel.id);
    print(isFav);
    return isFav;
  }

  static isStoreFavourite(
      {required StoreModel storeModel, required List<StoreModel> favourites}) {
    bool isFav = favourites.any((storeToCheck) => storeToCheck.id == storeModel.id);
    print(isFav);
    return isFav;
  }
}

class DateUtil {
  static strDate(final DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  static showTimeRange(TimeOfDay from, TimeOfDay to) {
    return '${from.hour} : ${from.minute} ${from.period.name.toUpperCase()} to ${to.hour} : ${to.minute} ${to.period.name.toUpperCase()}';
  }

  static showTimeSelected(TimeOfDay time) {
    return '${time.hour.toString()} : ${time.minute.toString()} ${time.period.toString().toUpperCase()}';
  }

  static displayDiffrence(final DateTime from, final DateTime to) {
    return " x ${from.day - to.day} Days";
  }

  static displayRange(final DateTime from, final DateTime to) {
    if (from.isAfter(to)) {
      return '0';
    }
    if (_isSameDate(from, to)) {
      return '0';
    }

    if (_isSameMonthYear(from, to)) {
      return '${from.day - to.day}';
    }

    if (_isSameYear(from, to)) {
      return '${from.day - to.day}';
    }

    return '${from.day - to.day}';
  }

  static displayTimeRange({required TimeOfDay from, required TimeOfDay to}) {
    return "${from.hour}:${from.minute} ${from.period.name} to ${to.hour}:${to.minute} ${to.period.name}";
  }

  static bool _isSameDate(DateTime from, DateTime to) {
    return from.day == to.day && _isSameMonthYear(from, to);
  }

  static _labeledDay(String day) {
    if (day.endsWith('1')) return day + 'st';
    if (day.endsWith('2')) return day + 'nd';
    if (day.endsWith('3')) return day + 'rd';
    return day + 'th';
  }

  static String _getMonthStr(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
    throw BusinessException('invalid-month', 'invalid month index: $month');
  }

  static _labeledMonth(int month) {
    return _getMonthStr(month);
  }

  static bool _isSameMonthYear(DateTime from, DateTime to) {
    return from.month == to.month && _isSameYear(from, to);
  }

  static bool _isSameYear(DateTime from, DateTime to) {
    return from.year == to.year;
  }
}

class EnumUtil {
  static T strToEnum<T extends Enum>(List<T> values, String str) {
    return values.firstWhere((element) => str.toLowerCase() == element.name);
  }

  static T? strToEnumNullable<T extends Enum>(List<T> values, String? str) {
    return str != null ? strToEnum(values, str) : null;
  }
}

class ZipUtil {
  static int? parseZip(String? zip) {
    if (zip == null) {
      return null;
    }
    if (zip.contains('-')) {
      return int.parse(zip.split('-')[0]);
    }
    return int.parse(zip);
  }
}

class NameUtil {
  static String getInitials(final String? name, final String? surname) {
    return ((name?.substring(0, 1) ?? '') + (surname?.substring(0, 1) ?? ''))
        .toUpperCase();
  }

  static String getFullName(final String? name, final String? surname) {
    return "$name $surname";
  }
}

Widget? modelToWidget<T>(T? model, Widget Function(T) mapper) {
  return model != null ? mapper.call(model) : null;
}

class NumberUtil {
  static T getLower<T extends num>(T num1, T num2) {
    return num1 <= num2 ? num1 : num2;
  }

  static String padNumber(num num, {String? left = '0', int length = 0}) {
    if (num == 0) return '0';
    final String strNum = num.toString();
    if (length == 0 || length < strNum.length) return strNum;
    String padded = '';
    for (int i = 0; i < length - strNum.length; i++) {
      padded += left!;
    }
    return padded + strNum;
  }
}
