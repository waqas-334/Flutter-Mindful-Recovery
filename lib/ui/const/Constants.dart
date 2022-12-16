import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kButtonCornerRadius = 48.0;
const kButtonStrokeWidth = 1.0;


const kPrivacyPolicyUrl = "https://flutter.dev";

const kSizedBox10 = SizedBox(height: 10,width: 10,);

const kLargeTextStyle = TextStyle(color: Colors.blue, fontSize: 32);

Widget kEmptyExpander = Expanded(
  child: Container(
    width: double.infinity,
    // color: Colors.black,
    // child: Text("Time"),
  ),
);

Widget kRedContainer = Container(color: Colors.red,height: 20,width: 20,);