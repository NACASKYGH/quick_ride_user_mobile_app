import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:age_calculator/age_calculator.dart';
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
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(this);

  bool get isPhone {
    String phone = replaceFirst('0', '');
    return PhoneNumber.parse('+233$phone').isValid();
  }

  String get capitalize =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  DateTime? get toDateTime {
    return DateTime.tryParse(this);
  }

  DateTime? get toDateTime2 {
    final format = DateFormat('MM/dd/y h:m:s a');
    return format.parse(this);
  }

  DateTime? get toDateTime3 {
    final format = DateFormat('dd-MMM-y h:m');
    return format.parse(this);
  }

  TimeOfDay get stringDateToTimeOfDay {
    final format = DateFormat.jm(); //"6:00 AM"

    return TimeOfDay.fromDateTime(format.parse(this).toTimeZone);
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

  String get toHTTPS {
    if (startsWith('http://')) {
      return replaceFirst('http://', 'https://');
    }
    return this;
  }

  String splitMerge(String pattern, {String joiner = ' '}) {
    return split(pattern).map((e) => e.capitalize).join(joiner);
  }

  String splitRemoveMerge(
    String pattern,
    List<int> indexes, {
    String joiner = ', ',
  }) {
    final splitList = split(pattern);
    return splitList
        .mapIndexed((index, e) {
          //Remove if in the index
          if (indexes.contains(index)) return '';

          //Add - {last value} to the end
          if (index == splitList.length - 1) {
            return '-${e.trim().capitalize}';
          }

          return e.trim().capitalize;
        })
        .where((e) => e.trim().isNotEmpty)
        .join(joiner)
        .replaceFirst(', -', ' - ');
  }

  String splitReturnMerge(
    String pattern,
    List<int> indexes, {
    String joiner = ', ',
  }) {
    final splitList = split(pattern);
    return splitList
        .mapIndexed((index, e) {
          //Remove if not in the index
          if (!indexes.contains(index)) return '';

          return e.trim().capitalize;
        })
        .where((e) => e.trim().isNotEmpty)
        .join(joiner);
  }

  String get filterDialCode => trim().startsWith('+') ? this : '+$this';

  bool get isValidPhone {
    return PhoneNumber.parse('+233$this').isValid();
  }

  bool get isNotFound {
    return toLowerCase().contains('no') && toLowerCase().contains('record');
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

  /// June 2023
  String get fMonthFYear {
    return DateFormat('MMMM y').format(toTimeZone);
  }

  /// 18-Feb-2025
  String get ddMMMy {
    return DateFormat('dd-MMM-y').format(toTimeZone);
  }

  /// June 1, 2023
  String get fMonthDayFYear {
    return DateFormat('MMMM d, y').format(toTimeZone);
  }

  ///01-Jun-2023
  String get dateMMMonthYear {
    return DateFormat('dd-MMM-y').format(toTimeZone);
  }

  ///Mon 1 Jun. 2023
  String get dayMonthDayFYear {
    return DateFormat('EEE. d MMM. y').format(toTimeZone);
  }

  ///1 Jun. 2023
  String get monthDayFYear {
    return DateFormat('dd MMM y').format(toTimeZone);
  }

  /// 1 Jun. 2023
  String get dMMMY {
    return DateFormat('d MMM. y').format(toTimeZone);
  }

  /// Tue, June 1, 2023
  String get fullDate1 {
    return DateFormat('EEE, MMM d, y').format(toTimeZone);
  }

  /// Tue, June 1
  String get fullDate2 {
    return DateFormat('EEE, MMM d').format(toTimeZone);
  }

  ///  01 June
  String get dateAndMonth {
    return DateFormat('d MMM').format(toTimeZone);
  }

  /// Tue, June 1, 2023 at 12:20 AM
  String get fullDateAtTime {
    return '${DateFormat('EEE, MMM d, y').format(toTimeZone)} at '
        '${DateFormat('h:mm a').format(toTimeZone)}';
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

  ///12:20 AM
  String get getTime {
    return DateFormat('h:mm a').format(toTimeZone);
  }

  //2024-02-23 17:00:04
  String get phpStandardTime {
    return '$dateFormat2'
        ' ${DateFormat('h:mm:ss').format(toTimeZone)}';
  }

  DateTime get toTimeZone {
    return this;
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  DateDuration get getAge => AgeCalculator.age(this);
}

extension IntX on int {
  String get to2val {
    if (isNegative) {
      return abs() < 10 ? '-0${abs()}' : toString();
    }
    return this < 10 ? '0$this' : toString();
  }
}

extension NumX on num {
  String discountPrice(num discount) {
    if (discount <= 0) return asCurrency;
    num dis = (discount / 100) * this;
    return (this - dis).asCurrency;
  }

  String get asCurrency {
    var f = NumberFormat('###,###.0#', 'en_US');
    return f.format(this);
  }
}

extension DioExceptionX on DioException {
  String get formattedError {
    if (error is SocketException) {
      return 'Check your internet connection!';
    } else if (error is TimeoutException) {
      return 'Check your internet connection!';
    } else {
      // return response.toString();
      String errorMsg =
          (response?.data['errors'] ??
                  response?.data['message'] ??
                  response?.data ??
                  this)
              .toString();

      String msg = errorMsg
          .split(':')
          .mapIndexed((index, val) {
            if (index == 0 && val.split(' ').length == 1) return '';
            return val;
          })
          .join(' ')
          .replaceAll('}', '')
          .replaceAll('_', ' ');

      return msg;
    }
  }
}

extension MapX on Map<String, dynamic> {
  Map<String, dynamic> get filterOutNulls {
    final Map<String, dynamic> filtered = <String, dynamic>{};
    forEach((String key, dynamic value) {
      if (value != null) {
        filtered[key] = value;
      }
    });
    return filtered;
  }
}
