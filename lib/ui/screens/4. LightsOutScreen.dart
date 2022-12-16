import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../widgets/FilledRoundCornerButton.dart';
import '../widgets/OutlineButton.dart';

class LightsOutScreen extends StatefulWidget {
  const LightsOutScreen({Key? key}) : super(key: key);

  @override
  State<LightsOutScreen> createState() => _LightsOutScreenState();
}

class _LightsOutScreenState extends State<LightsOutScreen> {
  late TimeOfDay timeOfDay;

  @override
  void initState() {
    timeOfDay = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      Text("What time did I go to sleep?"),
      kSizedBox10,
      kSizedBox10,
      InkWell(
        onTap: timeClicked,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              timeOfDay.format(context),
              style: kLargeTextStyle,
            ),
          ],
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("Total Sleep Time"),
      kSizedBox10,
      kSizedBox10,
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TimeOfDay.now().format(context),
            style: kLargeTextStyle.copyWith(color: Colors.black),
          ),
        ],
      ),
      kSizedBox10,
      kSizedBox10,
      Text("Comments"),
      kSizedBox10,
      const TextField(
        maxLines: 10,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
      Spacer(),
      // Expanded(child: kRedContainer),
      Row(
        children: [
          // MyFilledRoundCornerButton(label: "Continue", onButtonClick: () {}),
          Expanded(
              flex: 2,
              child: MyOutlineButton(
                label: "Skip",
                onButtonClick: _skipClicked,
                colors: Colors.black,
                horizontalMargin: 0.0,
                // horizontalPadding: 0.0,
              )),
          kSizedBox10,
          Expanded(
            flex: 3,
            child: MyFilledRoundCornerButton(
              label: "Continue",
              onButtonClick: _continueClicked,
              horizontalPadding: 0.0,
            ),
          ),
          Container(color: Colors.red),
        ],
      )
    ]);
  }

  void timeClicked() {
    showTimePicker(context: context, initialTime: timeOfDay).then((value) {
      //TimeOfDay to DateTime
      print("TIMEPICKER: ${value?.hour ?? 00}:${value?.minute ?? 00}");
      if (value != null) {
        setState(() {
          timeOfDay = value;
        });
      }
    });
  }

  void _skipClicked() {}

  void _continueClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ActivityScreen()));
  }
}
