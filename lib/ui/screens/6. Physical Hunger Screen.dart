import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/FilledRoundCornerButton.dart';
import '7. Eaten.dart';

enum YesOrNo { YES, NO }

class PhysicalHunger extends StatefulWidget {
  const PhysicalHunger({Key? key}) : super(key: key);

  @override
  State<PhysicalHunger> createState() => _PhysicalHungerState();
}

class _PhysicalHungerState extends State<PhysicalHunger> {
  YesOrNo? isPhysicalHungary = null;

  List<String> get _options {
    return ["Very Hungary", "A Little Hungary", "Hungary"];
  }

  late String selectedValue;

  @override
  void initState() {
    selectedValue = _options[0];
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("Am I experiencing any Physical Hunger?"),
      kSizedBox10,
      kSizedBox10,
      ListTile(
        onTap: () {
          onRadioChanged(YesOrNo.YES);
        },
        title: Text("Yes"),
        leading: Radio(
          value: YesOrNo.YES,
          groupValue: isPhysicalHungary,
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
          groupValue: isPhysicalHungary,
          onChanged: onRadioChanged,
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      if (isPhysicalHungary == YesOrNo.YES)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.blue),
          ),
          child: DropdownButton(
            isExpanded: true,
            underline: Container(),
            borderRadius: BorderRadius.circular(8),
            value: selectedValue,
            items: _options
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) selectedValue = value;
              });
            },
            hint: const Text("Please select one"),
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
      isPhysicalHungary = value;
    });
  }

  void _continueClicked() {
    if (isPhysicalHungary == null) {
      Fluttertoast.showToast(
        msg: "Please select one option",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Eaten()));
  }
}
