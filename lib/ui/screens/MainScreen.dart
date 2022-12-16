import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/TimeAndDateScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/OutlineButton.dart';

import '../const/Constants.dart';
import '../widgets/FilledRoundCornerButton.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
      label: 'Self Care check in',
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

  void onSettingsClicked(context) {}

  void onProceedSelfCareClicked(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TimeAndDateScreen()));
  }

  void onViewDataClicked(BuildContext context) {}

  void onExportDataClicked(BuildContext context) {}
}
