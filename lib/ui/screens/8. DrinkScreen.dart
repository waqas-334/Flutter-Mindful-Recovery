import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/9.%20FeelingScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '6. Physical Hunger Screen.dart';
import '../util/Extensions.dart';
class DrinkScreen extends StatefulWidget {
  Record? record;
  DrinkScreen(this.record, {Key? key}) : super(key: key);

  @override
  State<DrinkScreen> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  YesOrNo? isWaterOrTea = null;
  YesOrNo? isDrinkingNow = null;


  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("Thirst: Have I consumed any any water or tea today?", style: kQuestionTextStyle),
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: isWaterOrTea,
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
          groupValue: isWaterOrTea,
          onChanged: onRadioChanged,
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      // const Text("Was it an abstinent meal?", style: kQuestionTextStyle),
      // kSizedBox10,
      // kSizedBox10,
      // ListTile(
      //   onTap: () {
      //     onRadioChanged2(YesOrNo.YES);
      //   },
      //   title: Text("Yes"),
      //   leading: Radio(
      //     value: YesOrNo.YES,
      //     groupValue: isDrinkingNow,
      //     onChanged: onRadioChanged2,
      //   ),
      // ),
      // ListTile(
      //   onTap: () {
      //     onRadioChanged2(YesOrNo.NO);
      //   },
      //   title: Text("No"),
      //   leading: Radio(
      //     value: YesOrNo.NO,
      //     groupValue: isDrinkingNow,
      //     onChanged: onRadioChanged2,
      //   ),
      // ),
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
      isWaterOrTea = value;
    });
  }

  void onRadioChanged2(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      isDrinkingNow = value;
    });
  }

  void _continueClicked() {
    if (isWaterOrTea == null) {
      Fluttertoast.showToast(
        msg: "Please answer all questions",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }

    widget.record?.have_I_consumed_any_water_or_tea = isWaterOrTea?.toShortString();
    // widget.record?.drink_was_it_abstinent = isDrinkingNow?.toShortString();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  FeelingScreen(widget.record)));

  }
}
