import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mindful_recovery/ui/screens/1.1.2%20ViewDataSelectionScreen.dart';
import 'package:flutter_mindful_recovery/ui/screens/1.2%20SettingsScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/OutlineButton.dart';

import '../../main.dart';
import '../const/Constants.dart';
import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '2. TimeAndDateScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Record record = Record();

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  @override
  Widget build(BuildContext context) {
    Widget settingsButton = Align(
      alignment: Alignment.topRight,
      child: InkWell(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.settings,
            size: 30.0,
          ),
        ),
        onTap: () {
          onSettingsClicked(context);
        },
      ),
    );
    Widget welcomeText = const Text(
      "Welcome",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );

    Widget btnProceedWithSelfCheckIn = MyFilledRoundCornerButton(
      label: 'Self Care Check In',
      onButtonClick: () {
        onProceedSelfCareClicked(context);
      },
      radius: 8,
    );

    Widget btnViewData = MyOutlineButton(
      label: "View Data",
      onButtonClick: () {
        onViewDataClicked(context);
      },
      colors: Colors.blue,
      radius: 8,
    );

    Widget btnExportData = MyOutlineButton(
      label: "Export Data",
      onButtonClick: () {
        onExportDataClicked(context);
      },
      colors: Colors.blue,
      radius: 8,
    );

    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          settingsButton,
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                btnProceedWithSelfCheckIn,
                kSizedBox10,
                btnViewData,
                kSizedBox10,
                btnExportData
              ],
            ),
          )
        ],
      ),
    ));
  }

  void onSettingsClicked(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  void onProceedSelfCareClicked(BuildContext context) {
    // var route = MaterialPageRoute(builder: (context) => const TimeAndDateScreen());
    Navigator.pushNamed(context, TimeAndDateScreen.routeName, arguments: record);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const TimeAndDateScreen()));
  }

  void onViewDataClicked(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ViewDataSelectionScreen(false)));

    var notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
          'daily notification channel id', 'daily notification channel name',
          channelDescription: 'daily notification description'),
    );

    flutterLocalNotificationsPlugin.periodicallyShow(
        123, "30 Sec Notification", "body", RepeatInterval.every10Minues, notificationDetails);

  }


  var secondsToAdd = 0;

  tz.TZDateTime _nextInstanceOfTenAM() {
    secondsToAdd += 2;
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, now.hour, now.minute, now.second + secondsToAdd);
    // if (scheduledDate.isBefore(now)) {
    //   print("SCHEDULE DATE IS IN PASTE");
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    // }
    print("NOTIFICATION SCHEDULED AT: $scheduledDate");
    return scheduledDate;
  }

  void onExportDataClicked(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ViewDataSelectionScreen(true)));
  }
}
