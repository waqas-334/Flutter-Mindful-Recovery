import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/MainScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/ButtonBack.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import 'PrivacyPolicyScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _listOfTimeOptions = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

  // final _listOfTimeOptions = [1, 2, 3, 5, 6];

  var _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = _listOfTimeOptions[0];
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
                  .map((e) => DropdownMenuItem(
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
        ]);
  }

  void _remindMeAfterClicked() {}

  void _aboutUsClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyWebView(kAboutUsUrl)));
  }

  void _onPrivacyPolicyClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyWebView(kPrivacyPolicyUrl)));
  }
}
