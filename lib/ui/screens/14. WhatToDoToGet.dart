import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/screens/15.%20BathroomBreak.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '5. ActivityScreen.dart';

class WhatToDoToGet extends StatefulWidget {
  Record? record;
  WhatToDoToGet(this.record, {Key? key}) : super(key: key);

  List<FilterChipOption> options = [
    "Meditate",
    "Call Someone",
    "Help Someone",
    "Read",
    "Listen to Music",
    "No Compulsive exercise/move my body",
    "Learn Something",
    "Hobby",
    "Pray",
    "Lean into your HP in whatever way works",
    "Take a nap"
  ].map((e) => FilterChipOption(e, false)).toList();

  @override
  State<WhatToDoToGet> createState() => _WhatToDoToGetState();
}

class _WhatToDoToGetState extends State<WhatToDoToGet> {
  final myController = TextEditingController();

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
      const Text("What can I do to get what I really want?", style: kQuestionTextStyle),
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


    String commentText = myController.text;
    widget.record?.what_can_I_do_to_get_what_I_want = selectedOptions.toShortString();
    widget.record?.what_can_I_do_to_get_what_I_want_comment = myController.text;


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  BathRoomBreak(widget.record)));


  }
}
