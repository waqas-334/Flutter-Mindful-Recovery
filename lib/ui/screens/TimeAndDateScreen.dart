import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/WakeUpScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/appbar%20content/AppBarConstants.dart';
import 'package:intl/intl.dart';

import '../widgets/FilledRoundCornerButton.dart';

class TimeAndDateScreen extends StatefulWidget {
  const TimeAndDateScreen({Key? key}) : super(key: key);

  @override
  State<TimeAndDateScreen> createState() => _TimeAndDateScreenState();
}

class _TimeAndDateScreenState extends State<TimeAndDateScreen> {
  late TimeOfDay timeOfDay;
  late DateTime dateTime;

  @override
  void initState() {
    // super.initState();
    timeOfDay = TimeOfDay.now();
    dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMM y');
    final date = formatter.format(dateTime);

    Widget timeText = const Text("Time");
    Widget dateText = const Text("Date");
    Widget timePicker = InkWell(
      onTap: () {
        onTimeClicked(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${timeOfDay.format(context)} ",
            style: kLargeTextStyle,
          )
        ],
      ),
    );

    Widget datePicker = InkWell(
      onTap: () {
        onDateClicked(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: kLargeTextStyle,
          )
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              kAppBar,
              kEmptyExpander,
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateText,
                      kSizedBox10,
                      kSizedBox10,
                      datePicker,
                      kSizedBox10,
                      kSizedBox10,
                      kSizedBox10,
                      kSizedBox10,
                      timeText,
                      timePicker,
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MyFilledRoundCornerButton(
                      label: 'Continue',
                      onButtonClick: () {
                        onContinueClicked(context);
                      },
                    ),
                  ),
                  // color: Colors.green,
                  // child: Text("Time"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onContinueClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  WakeUpScreen()));
  }

  void onTimeClicked(BuildContext context) {
    showTimePicker(context: context, initialTime: timeOfDay).then(
      (value) {
        setState(() {
          // if (value == null) {
          //   Fluttertoast.showToast(
          //       msg: "Something went wrong, please try again later",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // } else {
          //   {
          if (value != null) {
            timeOfDay = value;
          }
          // }
          // }
        });
      },
    );
  }

  void onDateClicked(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: dateTime,
            firstDate: DateUtils.addDaysToDate(dateTime, -30),
            lastDate: DateUtils.addDaysToDate(dateTime, 30))
        .then((value) {
      // if (value == null) {
      //   Fluttertoast.showToast(
      //       msg: "Something went wrong, please try again later",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // } else {
      //   {
      if (value != null) {
        setState(() {
          dateTime = value;
        });
      }
      // }
      // }
    });
  }
}
