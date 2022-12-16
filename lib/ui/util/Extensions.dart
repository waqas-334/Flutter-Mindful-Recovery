import 'dart:core';

import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  static DateTime fromTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) throw Exception("Time of Day is null");
    var todaysDate = DateTime.now();
    DateTime dateTime = DateTime(
        todaysDate.year, todaysDate.day, timeOfDay.hour, timeOfDay.minute);
    return dateTime;
  }

  void NonStatic() {}
}
