import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/widgets/ButtonBack.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../widgets/FilledRoundCornerButton.dart';
import 'PrivacyPolicyScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String TIME_OPTION_KEY  = "time_option";
  final _listOfTimeOptions = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

  // final _listOfTimeOptions = [1, 2, 3, 5, 6];

  late int _selectedOption;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _selectedOption = _listOfTimeOptions[0];
    getSharedPrefs();
  }

  void getSharedPrefs() async{
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
    _selectedOption = sharedPreferences.getInt(TIME_OPTION_KEY)??0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      padding: 0.0,
      appBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: const [
            kBackButton,
            Expanded(
              flex: 20,
              child: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: DropdownButton(
            icon: null,
            isExpanded: true,
            underline: Container(),
            // value: _selectedOption,
            items: _listOfTimeOptions
                .map((e) =>
                DropdownMenuItem(
                  value: e,
                  child: Text("$e minutes"),
                ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedOption = value;
              });
            },
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Remind me after"),
                Text(
                  "$_selectedOption",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            // child: Container(
            //   // color: Colors.amber,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: const [
            //         Text("Remind me after"),
            //         Text(
            //           "15 Minutes",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: double.infinity,
        ),
        InkWell(
          onTap: _aboutUsClicked,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("About Us"),
              )
            ],
          ),
        ),
        InkWell(
          onTap: _onPrivacyPolicyClicked,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Privacy Policy"),
              )
            ],
          ),
        ),
        Spacer(),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MyFilledRoundCornerButton(
                label: 'Save',
                onButtonClick: () {
                  onSaveClicked(context);
                },
              ),
            ),
            // color: Colors.green,
            // child: Text("Time"),
          ),
        ),
      ],
    );
  }

  void onSaveClicked(BuildContext buildContext){
    var notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
          'daily notification channel id', 'daily notification channel name',
          channelDescription: 'daily notification description'),
    );

    RepeatInterval? interval = getRepeatIntervalFromSelectedValue();
    print("INTERVAL : $interval\tSelected Options: $_selectedOption");

    sharedPreferences.setInt(TIME_OPTION_KEY, _selectedOption);
    flutterLocalNotificationsPlugin.periodicallyShow(
        Random().nextInt(1000),
        "Mindful Recovery",
        "Time to Record new data.asdasdsa",
        RepeatInterval.every5Minues,
        notificationDetails);
    //
    // if (interval == null){
    //   flutterLocalNotificationsPlugin.cancelAll();
    // }else {
    //
    // }

    Navigator.of(context).pop();

  }


  RepeatInterval? getRepeatIntervalFromSelectedValue() {
    switch (_selectedOption) {
      case 0:
      //Stop showing notification here
        return null;
      case 5:
      //5 minutes
        return RepeatInterval.every5Minues;
      case 10:
      //10 minutes
        return RepeatInterval.hourly;
      case 15:
      //15 minutes
        return RepeatInterval.every15Minutes;
      case 20:
      //20 minutes
        return RepeatInterval.every20Minutes;
      case 25:
      //25 minutes
        return RepeatInterval.every25Minutes;
      case 30:
      //10 minutes
        return RepeatInterval.every30Minutes;
      case 35:
      //35 minutes
        return RepeatInterval.every35Minutes;
      case 40:
      //40 minutes
        return RepeatInterval.every40Minutes;
      case 45:
      //40 minutes
        return RepeatInterval.every45Minutes;
      case 50:
      //45 minutes
        return RepeatInterval.every50Minutes;
      case 55:
      //50 minutes
        return RepeatInterval.every55Minutes;
      // case 60:
      // 55 minutes
      //   return RepeatInterval.hourly;
      default:
        return null;
    }
  }

  void _aboutUsClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyWebView(kAboutUsUrl)));
  }

  void _onPrivacyPolicyClicked() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MyWebView(kPrivacyPolicyUrl)));
  }
}
