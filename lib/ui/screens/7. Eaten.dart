import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/FilledRoundCornerButton.dart';
import '6. Physical Hunger Screen.dart';

class Eaten extends StatefulWidget {
  @override
  State<Eaten> createState() => _EatenState();
}

class _EatenState extends State<Eaten> {
  YesOrNo? isEaten = null;
  YesOrNo? isAbstinentMeal = null;

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("Have I eaten?"),
      kSizedBox10,
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: isEaten,
          onChanged: onRadioChanged,
        ),
      ),
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.NO);
        },
        title: Text("No"),
        leading: Radio(
          value: YesOrNo.NO,
          groupValue: isEaten,
          onChanged: onRadioChanged,
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      Text("Was it an abstinent meal?"),
      kSizedBox10,
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged2(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: isAbstinentMeal,
          onChanged: onRadioChanged2,
        ),
      ),
      ListTile(
        onTap: () {
          onRadioChanged2(YesOrNo.NO);
        },
        title: Text("No"),
        leading: Radio(
          value: YesOrNo.NO,
          groupValue: isAbstinentMeal,
          onChanged: onRadioChanged2,
        ),
      ),
      Spacer(),
      MyFilledRoundCornerButton(
        label: "Continue",
        onButtonClick: _continueClicked,
        horizontalPadding: 0.0,
      ),
    ]);
  }

  void onRadioChanged(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      isEaten = value;
    });
  }

  void onRadioChanged2(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      isAbstinentMeal = value;
    });
  }

  void _continueClicked() {
    if (isEaten==null || isAbstinentMeal == null){
      Fluttertoast.showToast(
        msg: "Please answer all questions",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }
  }
}
