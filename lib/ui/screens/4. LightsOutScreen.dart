import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/data/Record.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/util/MyTimeOfDay.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../widgets/FilledRoundCornerButton.dart';
import '../widgets/OutlineButton.dart';

class LightsOutScreen extends StatefulWidget {
  Record? record;

  LightsOutScreen(this.record, {Key? key}) : super(key: key);

  @override
  State<LightsOutScreen> createState() => _LightsOutScreenState();
}

class _LightsOutScreenState extends State<LightsOutScreen> {
  late TimeOfDay timeOfDay;
  var controller = TextEditingController();
  var totalSleepTime = "--";
  Duration?
      sleepDuration; //Last day sleep time - today's wakeup time = sleep hours

  @override
  void initState() {
    timeOfDay = TimeOfDay.now();
  }

  String calculateDuration() {
    DateTime d = DateTime.now();
    DateTime bedTime =
        DateTime(d.year, d.month, d.day, timeOfDay.hour, timeOfDay.minute);
    DateTime wakeUpTime = DateTime(d.year, d.month, d.day,
        widget.record!.wake_up_time!.hour, widget.record!.wake_up_time!.minute);
    sleepDuration = bedTime.difference(wakeUpTime);

    if (sleepDuration?.isNegative == true) return "invalid sleep/wakeup time";

    return "${sleepDuration?.inHours} Hours ${sleepDuration!.inMinutes % 60} Minutes";
  }

  @override
  Widget build(BuildContext context) {
    print("DATE TIME: ${calculateDuration()}");

    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      const Text("What time did I go to sleep?", style: kQuestionTextStyle,),
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
      const Text("Total Sleep Time", style: kQuestionTextStyle),
      kSizedBox10,
      kSizedBox10,
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            calculateDuration(),
            style: kLargeTextStyle.copyWith(color: Colors.black),
          ),
        ],
      ),
      kSizedBox10,
      kSizedBox10,
      Text("Comments", style: kQuestionTextStyle),
      kSizedBox10,
      TextField(
        controller: controller,
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

  void _skipClicked() {

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ActivityScreen(widget.record)));
  }

  void _continueClicked() {
    widget.record?.what_time_I_go_to_sleep = MyTimeOfDay.fromTimeOfDay(timeOfDay);
    widget.record?.what_time_I_go_to_sleep_comment = controller.text;
    if (sleepDuration != null && !sleepDuration!.isNegative == true) {
      widget.record?.sleepDuration = sleepDuration!.inMinutes;
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ActivityScreen(widget.record)));
  }
}
