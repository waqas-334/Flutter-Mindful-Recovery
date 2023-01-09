import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/data/Record.dart';
import 'package:flutter_mindful_recovery/ui/screens/4.%20LightsOutScreen.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/util/MyTimeOfDay.dart';
import 'package:flutter_mindful_recovery/ui/widgets/OutlineButton.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../const/Constants.dart';
import '../util/DB.dart';
import '../widgets/FilledRoundCornerButton.dart';
import 'MainScreen.dart';

class WakeUpScreen extends StatefulWidget {
  Record? record;

  WakeUpScreen(this.record, {super.key});

  @override
  State<WakeUpScreen> createState() => _WakeUpScreenState();
}

enum QualityOfSleep { Great, Poor }

class _WakeUpScreenState extends State<WakeUpScreen> {
  late TimeOfDay timeOfDay;

  QualityOfSleep? _quality_of_sleep = null;

  @override
  void initState() {
    // super.initState();
    timeOfDay = TimeOfDay.now();
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return MainContainer(
      children: [
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        const Text("What time did I wake up?", style: kQuestionTextStyle,),
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
        const Text("What was the quality of the sleep?", style: kQuestionTextStyle,),
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
        const Text("Comments", style: kQuestionTextStyle,),
        kSizedBox10,
        TextField(
          maxLines: 5,
          controller: myController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
        ),
        kSizedBox10,
        kSizedBox10,
        Spacer(),
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

  void _skipClicked() {

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ActivityScreen(widget.record)));
  }

  void _continueClicked() {
    Navigator.popUntil(context, ModalRoute.withName(MainScreen.routeName));

    return;

    if(_quality_of_sleep==null){
      Fluttertoast.showToast(
        msg: "Please select one option",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }

    widget.record?.wake_up_time = MyTimeOfDay.fromTimeOfDay(timeOfDay);
    widget.record?.quality_of_sleep = _quality_of_sleep?.toShortString();
    widget.record?.sleep_comment = myController.text;




    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => LightsOutScreen(widget.record)));
  }
}
