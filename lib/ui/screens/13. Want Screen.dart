import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/14.%20WhatToDoToGet.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';

enum WhatIWant {
  Comfort,
  Reward,
  Relaxation,
  Non_Codependent_Companionship,
  Nurturance
}

class WantScreen extends StatefulWidget {
  Record? record;
  WantScreen(this.record, {Key? key}) : super(key: key);

  @override
  State<WantScreen> createState() => _WantScreenState();
}

class _WantScreenState extends State<WantScreen> {
  WhatIWant? whatIWantGroupValue = null;
  final myController = TextEditingController();

  List<ListTile> get _listTiles {
    List<ListTile> values = [];
    for (var whatIWant in WhatIWant.values) {
      String whatIWantStringValue =
          whatIWant.toString().substring(10).replaceAll("_", " ");
      var tile = ListTile(
        onTap: () {
          onRadioChanged(whatIWant);
        },
        title: Text(whatIWantStringValue),
        leading: Radio(
          value: whatIWant,
          groupValue: whatIWantGroupValue,
          onChanged: onRadioChanged,
        ),
      );
      values.add(tile);
    }

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("What do I really want?", style: kQuestionTextStyle),
      kSizedBox10,
      ..._listTiles,

      // ListTile(
      //   onTap: () {
      //     onRadioChanged(WhatIWant.Comfort);
      //   },
      //   title: Text("Comfort"),
      //   leading: Radio(
      //     value: WhatIWant.Comfort,
      //     groupValue: whatIWantGroupValue,
      //     onChanged: onRadioChanged,
      //   ),
      // ),
      // ListTile(
      //   onTap: () {
      //     onRadioChanged(WhatIWant.Reward);
      //   },
      //   title: Text("Reward"),
      //   leading: Radio(
      //     value: WhatIWant.Reward,
      //     groupValue: whatIWantGroupValue,
      //     onChanged: onRadioChanged,
      //   ),
      // ),
      kSizedBox10,
      kSizedBox10,
      const Text("Comment:", style: kQuestionTextStyle),
      kSizedBox10,
      TextField(
        maxLines: 5,
        controller: myController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
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

  void onRadioChanged(WhatIWant? value) {
    if (value == null) {
      return;
    }

    setState(() {
      whatIWantGroupValue = value;
    });
  }

  void _continueClicked() {
    if(whatIWantGroupValue==null){
      showErrorToast();
      return;
    }
    String selectedValue =
        whatIWantGroupValue.toString().substring(10).replaceAll("_", " ");

    widget.record?.what_do_I_want = selectedValue;
    widget.record?.what_do_I_want_comment = myController.text;


    print("SELECTED VALUE: $selectedValue");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  WhatToDoToGet(widget.record)));



  }
}
