import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/10.%20Food%20Craving%20Screen.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../const/Constants.dart';
import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '../util/Extensions.dart';

class FeelingScreen extends StatefulWidget {
  Record? record;
  FeelingScreen(this.record, {Key? key}) : super(key: key);

  List<FilterChipOption> options = [
    "Anxiety",
    "Anger",
    "Bored",
    "Depressed",
    "Fearful",
    "Grateful",
    "Happy/Content",
    "Joyful",
    "Lonely",
    "Sad",
    "Tired"
  ].map((e) => FilterChipOption(e, false)).toList();

  @override
  State<FeelingScreen> createState() => _FeelingScreenState();
}

class _FeelingScreenState extends State<FeelingScreen> {
  List<Widget> _buildChips() {
    List<Widget> filterChips = [];
    for (int i = 0; i < widget.options.length; i++) {
      var chip = Theme(
        data: ThemeData.dark(),
        child: FilterChip(
          label: Text(
            widget.options[i].label,
            style: TextStyle(
                color: (widget.options[i].isSelected)
                    ? Colors.white
                    : Colors.black87),
          ),
          backgroundColor: Colors.grey[300],
          selected: widget.options[i].isSelected,
          onSelected: (bool value) {
            setState(
              () {
                widget.options[i].isSelected = value;
              },
            );
          },
          selectedColor: Colors.blue,
        ),
      );
      filterChips.add(chip);
    }

    return filterChips;
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("What am I feeling right now?", style: kQuestionTextStyle),
      kSizedBox10,
      Container(
        height: MediaQuery.of(context).size.height * 0.50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 6.0,
            // runSpacing: 6.0,
            children: _buildChips(),
          ),
        ),
      ),
      kSizedBox10,
      kSizedBox10,
      const Text("Other", style: kQuestionTextStyle),
      kSizedBox10,
      TextField(
        controller: myController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
      Spacer(),
      MyFilledRoundCornerButton(
        label: "Continue",
        onButtonClick: _continueClicked,
        horizontalPadding: 0.0,
      ),
    ]);
  }

  void _continueClicked() {
    List<String> selectedOptions = [];
    for (var element in widget.options) {
      if (element.isSelected) {
        selectedOptions.add(element.label);
      }
    }

    if(selectedOptions.isEmpty){
      showErrorToast();
      return;
    }

    widget.record?.what_I_am_feeling_rn =  selectedOptions.toShortString();
    widget.record?.what_I_am_feeling_rn_other =  myController.text;


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  FoodCravingScreen(widget.record)));

  }
}
