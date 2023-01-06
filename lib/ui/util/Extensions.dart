import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/6.%20Physical%20Hunger%20Screen.dart';
import 'package:flutter_mindful_recovery/ui/util/MyTimeOfDay.dart';

import '../screens/3. WakeUpScreen.dart';

extension DateTimeExtensions on DateTime {
  // static DateTime fromTimeOfDay(TimeOfDay? timeOfDay) {
  //   if (timeOfDay == null) throw Exception("Time of Day is null");
  //   var todaysDate = DateTime.now();
  //   DateTime dateTime = DateTime(
  //       todaysDate.year, todaysDate.day, timeOfDay.hour, timeOfDay.minute);
  //   return dateTime;
  // }

  String toYYYYMMDDformat() {
    var newMonth = month;
    String? strMonth;
    if (newMonth < 10) {
      strMonth = "0$month";
    }

    var newDay = day;
    String? strDay;
    if (newDay < 10) {
      strDay = "0$day";
    }

    var newDate = "$year${strMonth ?? newMonth}${strDay ?? newDay}";

    print("newDate: $newDate");
    return newDate;
  }

  String toReadableString() {
    return "$year-$month-$day";
  }
}

extension ParseToString on QualityOfSleep {
  String toShortString() {
    return toString().split(".").last;
  }
}

extension ParseToStrg on List<String> {
  String toShortString() {
    return toString().split("[").last.split("]").first;
  }
}

extension Parse2String on YesOrNo {
  String toShortString() {
    return toString().split(".").last;
  }
}

extension StringExtensions on String {
  DateTime toDateTime() {
    // return DateTime.parse(this);
    var list = split("-").toList().map((e) => int.parse(e)).toList();
    print(
        "DATE TO STRING CONVERSION: ${list.first}-${list.elementAt(1)}-${list.last}");
    return DateTime(list.first, list.elementAt(1), list.last);
  }

  DateTime fromYYYYMMDD() {
    var year = substring(0, 4);
    var month = substring(4, 6);
    var day = substring(6, 8);
    // print("fromYYYYMMDD: $year - $month - $day");
    DateTime dt = DateTime(
      int.parse(year),
      int.parse(month),
      int.parse(day),
    );
    return dt;
  }

  MyTimeOfDay? toTimeOfDay() {
    var splits = split(":");
    if(splits.first=="null") return null;
    int hour = int.parse(split(":").first);
    int minute = int.parse(split(":").last);
    print("toTimeOfDay: $hour:$minute");
    return MyTimeOfDay(hour: hour, minute: minute);
  }
}

extension TimeExtensions on TimeOfDay? {
  String? toTimeOfDay() {
    if (this == null) return null;
    return "${this?.hour}:${this?.minute}";
  }
}
