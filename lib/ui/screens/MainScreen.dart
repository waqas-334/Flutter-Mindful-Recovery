
import 'dart:io';

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
  bool _notificationsEnabled = false;

  @override
  void initState() {
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _isAndroidPermissionGranted();
    _requestPermissions();
  }


  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
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

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    flutterLocalNotificationsPlugin.show(21, "title", "body",notificationDetails, payload: 'item x');

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
