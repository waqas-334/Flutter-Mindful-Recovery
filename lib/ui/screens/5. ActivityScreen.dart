import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/6.%20Physical%20Hunger%20Screen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../widgets/FilledRoundCornerButton.dart';

class FilterChipOption {
  String label;
  bool isSelected;

  FilterChipOption(this.label, this.isSelected);
}

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<FilterChipOption> options = [
    FilterChipOption("Working", false),
    FilterChipOption("In a Meeting", false),
    FilterChipOption("At the gym", false),
    FilterChipOption("Watching TV", false),
    FilterChipOption("At the Movie Theater", false),
    FilterChipOption("Watching a live performance", false),
    FilterChipOption("Reading", false),
    FilterChipOption("Using the Cell Phone", false),
    FilterChipOption("Socializing", false),
    FilterChipOption("Chatting on the Phone", false),
    FilterChipOption("Driving to work", false),
    FilterChipOption("Driving home from work", false),
    FilterChipOption("Running errands", false),
    FilterChipOption("Eating Breakfast", false),
    FilterChipOption("Eating Lunch", false),
    FilterChipOption("Eating Dinner", false),
  ];

  List<Widget> _buildChips() {
    List<Widget> widgets = [];
    for (int i = 0; i < options.length; i++) {
      var chip = Theme(
        data: ThemeData.dark(),
        child: FilterChip(
          label: Text(
            options[i].label,
            style: TextStyle(
                color: (options[i].isSelected) ? Colors.white : Colors.black87),
          ),
          backgroundColor: Colors.grey[300],
          selected: options[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              options[i].isSelected = value;
            });
          },
          selectedColor: Colors.blue,
        ),
      );
      widgets.add(chip);
    }

    return widgets;
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("What I am doing right now? (Choose all that apply)"),
      kSizedBox10,
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
      Text("Comments"),
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
    options.forEach((element) {
      if (element.isSelected) {
        selectedOptions.add(element.label);
      }
    });
    print("SELECTED OPTIONS: $selectedOptions");
    print("COMMENT: , ${myController.text}");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PhysicalHunger()));
  }
}
