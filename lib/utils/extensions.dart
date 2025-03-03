import 'dart:math' show pow;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';


extension BuildContextX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDarkMode => colors.brightness == Brightness.dark;

  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}

extension GoRouterExt on GoRouter {
  String get _currentRoute =>
      routerDelegate.currentConfiguration.matches.last.matchedLocation;

  void popUntil(String path) {
    var currentRoute = _currentRoute;
    while (currentRoute != path && canPop()) {
      pop();
      currentRoute = _currentRoute;
    }
  }
}

extension StringX on String {
  bool get isEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  DateTime? get toDateTime {
    return DateTime.tryParse(this);
  }

  TimeOfDay get stringDateToTimeOfDay {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(this));
  }

  TimeOfDay get stringToTimeOfDay {
    List<String> timeList = split(':');
    int hour = int.tryParse(timeList.first) ?? 0;
    int min = int.tryParse(timeList.last) ?? 0;
    return TimeOfDay(hour: hour, minute: min);
  }

  double get toCompareDouble {
    TimeOfDay myTime = stringToTimeOfDay;
    return myTime.hour + myTime.minute / 60.0;
  }

  bool get isValidPhone {
    return PhoneNumber.parse('+233$this').isValid();
  }
}

extension DateTimeX on DateTime {
  /// 26/04/2023
  String get dateFormat1 {
    return DateFormat('d/MM/y').format(toTimeZone);
  }

  /// 2023-04-02
  String get dateFormat2 {
    return DateFormat('y-MM-dd').format(toTimeZone);
  }

  /// 18-Feb-2025
  String get ddMMMy {
    return DateFormat('dd-MMM-y').format(toTimeZone);
  }

  /// June 2023
  String get fMonthFYear {
    return DateFormat('MMMM y').format(toTimeZone);
  }

  /// 3
  String get dayNum1 {
    return DateFormat('d').format(toTimeZone);
  }

  /// 03
  String get dayNum2 {
    return DateFormat('dd').format(toTimeZone);
  }

  /// Monday
  String get dayText {
    return DateFormat('EEEE').format(toTimeZone);
  }

  String get timeAgo {
    return timeago.format(this);
  }

  String get timeAgoShort {
    return timeago.format(this, locale: 'en_short');
  }

  DateTime get toTimeZone {
    return this;
    // tz.initializeTimeZones();
    // tz.Location location = tz.getLocation(timeZoneLocationName);
    // return tz.TZDateTime.from(this, location);
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}

extension NumX on num {
  num quotient(num divisor) {
    if (this < 1) return 0;
    if (divisor.isInfinite || divisor < 1) return 0;
    return this / divisor;
  }

  num get getSleepInHrs => ((this / 60) * 10).truncate() / 10;

  (num, num) get getSleepTime {
    num hrs = getSleepInHrs.floor();
    num mins = (this / 60 - hrs) * 60;
    return (hrs, mins.ceil());
  }

  double truncateToDecimalPlaces(num fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}

extension IntX on int {
  String get to2val {
    return this < 10 ? '0$this' : toString();
  }
}

extension MapEventX on MapEvent {
  bool get isZoomEnd {
    return this is MapEventDoubleTapZoomEnd ||
        this is PointerPanZoomEndEvent ||
        this is MapEventDoubleTapZoomEnd;
  }

  bool get isZoomStart {
    return this is MapEventDoubleTapZoomStart ||
        this is PointerPanZoomStartEvent ||
        this is MapEventDoubleTapZoomStart;
  }
}
