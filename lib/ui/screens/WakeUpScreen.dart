import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/4.%20LightsOutScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/OutlineButton.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../const/Constants.dart';
import '../widgets/FilledRoundCornerButton.dart';

class WakeUpScreen extends StatefulWidget {
  @override
  State<WakeUpScreen> createState() => _WakeUpScreenState();
}

enum QualityOfSleep { Great, Poor }

class _WakeUpScreenState extends State<WakeUpScreen> {
  late TimeOfDay timeOfDay;

  QualityOfSleep _quality_of_sleep = QualityOfSleep.Great;

  @override
  void initState() {
    // super.initState();
    timeOfDay = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    // final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return MainContainer(
      children: [
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        Text("What time did I wake up?"),
        kSizedBox10,
        kSizedBox10,
        InkWell(
          onTap: _timeClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
        Text("What was the quality of the sleep?"),
        kSizedBox10,
        kSizedBox10,
        ListTile(
          onTap: () {
            onRadioChanged(QualityOfSleep.Great);
          },
          title: Text("Great/Slept Well"),
          leading: Radio(
            value: QualityOfSleep.Great,
            groupValue: _quality_of_sleep,
            onChanged: onRadioChanged,
          ),
        ),
        ListTile(
          onTap: () {
            onRadioChanged(QualityOfSleep.Poor);
          },
          title: Text("Poor/did not sleep well"),
          leading: Radio(
            value: QualityOfSleep.Poor,
            groupValue: _quality_of_sleep,
            onChanged: onRadioChanged,
          ),
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
        kSizedBox10,
        kSizedBox10,
        Row(
          children: [
            // MyFilledRoundCornerButton(label: "Contine", onButtonClick: () {}),
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
                )),
            Container(color: Colors.red),
          ],
        )
      ],
    );
  }

  void onRadioChanged(QualityOfSleep? value) {
    setState(() {
      if (value != null) {
        _quality_of_sleep = value;
      }
    });
  }

  void _timeClicked() {
    showTimePicker(context: context, initialTime: timeOfDay).then((value) {
      setState(() {
        if (value != null) {
          timeOfDay = value;
        }
      });
    });
  }

  void _skipClicked() {}

  void _continueClicked() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LightsOutScreen()));
  }
}
