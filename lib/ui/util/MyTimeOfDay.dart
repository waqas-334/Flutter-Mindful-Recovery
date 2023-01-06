import 'package:flutter/material.dart';

class MyTimeOfDay extends TimeOfDay {
  MyTimeOfDay({required super.hour, required super.minute});

  @override
  String toString() {
    return "${hour}:${minute}";
  }

  factory MyTimeOfDay.fromTimeOfDay(TimeOfDay timeOfDay){
    return MyTimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute);
  }

}
