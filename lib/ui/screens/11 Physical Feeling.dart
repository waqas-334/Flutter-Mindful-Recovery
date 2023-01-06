import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/12.%20Food%20Addict.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';

class PhysicalFeeling extends StatefulWidget {
  Record? record;

  PhysicalFeeling(this.record, {Key? key}) : super(key: key);

  List<FilterChipOption> options = [
    "Cold",
    "Pain",
    "Comfortable",
    "Fatigued",
    "Sick",
    "Sleepy",
    "Hot",
    "Uncomfortable",
    "Tense/tension",
  ].map((e) => FilterChipOption(e, false)).toList();

  @override
  State<PhysicalFeeling> createState() => _PhysicalFeelingState();
}

class _PhysicalFeelingState extends State<PhysicalFeeling> {
  TextEditingController? myController = null;

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
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("What am I physically feeling right now?",
          style: kQuestionTextStyle),
      kSizedBox10,
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
      kSizedBox10,
      const Text("Comment", style: kQuestionTextStyle),
      kSizedBox10,
      TextField(
        controller: myController,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        decoration: const InputDecoration(
            hintText:
                "if you do not see what you are feeling on the list write it here",
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

    if (selectedOptions.isEmpty) {
      showErrorToast();
      return;
    }

    widget.record?.physical_feeling_rn = selectedOptions.toShortString();
    widget.record?.physical_feeling_rn_comment = myController?.text.toString();

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FoodAddict(widget.record)));
  }
}
