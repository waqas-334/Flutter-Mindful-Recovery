import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kButtonCornerRadius = 48.0;
const kButtonStrokeWidth = 1.0;

const kPrivacyPolicyUrl = "https://humansunderconstruction.com/privacy-notice-for-app";
const kAboutUsUrl = "https://humansunderconstruction.com/mindful-recovery-app-info";

const kQuestionTextStyle = TextStyle(fontSize: 20);

const kSizedBox10 = SizedBox(
  height: 10,
  width: 10,
);

const kLargeTextStyle = TextStyle(color: Colors.blue, fontSize: 32);

Widget kEmptyExpander = Expanded(
  child: Container(
    width: double.infinity,
    // color: Colors.black,
    // child: Text("Time"),
  ),
);

Widget kRedContainer = Container(
  color: Colors.red,
  height: 20,
  width: 20,
);

void showErrorToast({message = "Please answer all questions"}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.red,
  );
}

