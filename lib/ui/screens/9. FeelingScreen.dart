import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/screens/5.%20ActivityScreen.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../const/Constants.dart';

class FeelingScreen extends StatefulWidget {
  FeelingScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("What am I feeling right now?"),
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
    ]);
  }
}
