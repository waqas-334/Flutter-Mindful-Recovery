import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/6.%20Physical%20Hunger%20Screen.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '../widgets/container/MainContainer.dart';
import '11 Physical Feeling.dart';
import '5. ActivityScreen.dart';
import '../util/Extensions.dart';

class FoodCravingScreen extends StatefulWidget {
  Record? recod;
  FoodCravingScreen(this.recod,{Key? key}) : super(key: key);

  List<FilterChipOption> options = [
    "Sugar",
    "Flour",
    "Salt",
    "Fatty Food",
    "Starches",
    "Volume",
    "Nuts",
    "Cheese",
    "Processed food of any kind",
    "Just want to eat anything"
  ].map((e) => FilterChipOption(e, false)).toList();

  @override
  State<FoodCravingScreen> createState() => _FoodCravingScreenState();
}

class _FoodCravingScreenState extends State<FoodCravingScreen> {
  YesOrNo? isCraving = null;
  late String selectedValue;
  final myController = TextEditingController();

  List<String> get _options {
    return ["Very Strong", "Strong", "Weak"];
  }

  @override
  void initState() {
    selectedValue = _options[0];
  }

  List<Widget> get _buildChips {
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

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      children: [
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        kSizedBox10,
        const Text("Am I having food cravings right now/mouth hunger?",  style: kQuestionTextStyle),
        kSizedBox10,
        ListTile(
          onTap: () {
            onRadioChanged(YesOrNo.YES);
          },
          title: Text("Yes"),
          leading: Radio(
            value: YesOrNo.YES,
            groupValue: isCraving,
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
            groupValue: isCraving,
            onChanged: onRadioChanged,
          ),
        ),
        if (isCraving == YesOrNo.YES)
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
        kSizedBox10,
        kSizedBox10,
        if (isCraving == YesOrNo.YES) ...[
          Text("What am I craving?", style: kQuestionTextStyle),
          kSizedBox10,
          Container(
            // height: MediaQuery.of(context).size.height * 0.50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.blue),
            //     borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 6.0,
                // runSpacing: 6.0,
                children: _buildChips,
              ),
            ),
          ),
          kSizedBox10,
        ],
        const Text("Comment", style: kQuestionTextStyle),
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
      ],
    );
  }

  void onRadioChanged(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      isCraving = value;
    });
  }

  void _continueClicked() {
    if (isCraving == null) {
      showErrorToast();
      return;
    }

    List<String> selectedOptions = [];
    for (var element in widget.options) {
      if (element.isSelected) {
        selectedOptions.add(element.label);
      }
    }

    if(isCraving == YesOrNo.YES && selectedOptions.isEmpty){
      showErrorToast();
      return;
    }

    widget.recod?.food_craving = isCraving?.toShortString();
    widget.recod?.food_craving_what = selectedOptions.toShortString();
    widget.recod?.food_craving_comment = myController.text;


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PhysicalFeeling(widget.recod)));
  }
}
