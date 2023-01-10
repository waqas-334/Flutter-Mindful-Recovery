import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/6.%20Physical%20Hunger%20Screen.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '13. Want Screen.dart';

class FoodAddict extends StatefulWidget {
  Record? record;
  FoodAddict(this.record, {Key? key}) : super(key: key);

  @override
  State<FoodAddict> createState() => _FoodAddictState();
}

class _FoodAddictState extends State<FoodAddict> {
  YesOrNo? isAddict = null;
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text(
          "As a food addict/compulsive overeater, we focus on food for fuel and nutrition, and nothing else. Will eating, binging, purging, or restricting food satisfy my emotional needs right now? ", style: kQuestionTextStyle),
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: isAddict,
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
          groupValue: isAddict,
          onChanged: onRadioChanged,
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      if (isAddict == YesOrNo.YES) ...[
        const Text("Explain", style: kQuestionTextStyle),
        kSizedBox10,
        TextField(
          controller: myController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
        ),
      ],
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
      isAddict = value;
    });
  }


  void _continueClicked() {
    if( isAddict == null){
      showErrorToast();
      return;
    }

    widget.record?.food_addict = isAddict?.toShortString();
    widget.record?.food_addict_explain = myController.text;

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  WantScreen(widget.record)));

  }

}
