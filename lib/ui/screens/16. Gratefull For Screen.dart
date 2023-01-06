import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:sqflite/sqflite.dart';

import '../data/Record.dart';
import '../util/DB.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '17. Completed.dart';
import '5. ActivityScreen.dart';

class GrateFullForScreen extends StatefulWidget {
  Record? record;

  GrateFullForScreen(this.record, {Key? key}) : super(key: key);

  List<FilterChipOption> options = [
    "Great job",
    "Friends",
    "Family",
    "My healthy body",
    "Love for others",
    "Self love/self care",
    "My partner",
    "My pets",
    "My income",
    "The 12 steps",
    "My home",
    "Self acceptance (I am enough)",
    "My children",
    "My high power",
    "My guardian angel",
    "The earth",
    "My abstinence/sobriety",
  ].map((e) => FilterChipOption(e, false)).toList();

  @override
  State<GrateFullForScreen> createState() => _GrateFullForScreenState();
}

class _GrateFullForScreenState extends State<GrateFullForScreen> {
  final myController = TextEditingController();

  Database? database;

  @override
  void initState() {
    super.initState();
    getDatabase().then((value) {
      database = value;
      print("RETRIVED DATABASE");
    });
  }

  Future<Database> getDatabase() async {
    var database = await openDatabase(
      DATABASE_NAME,
      onCreate: (db, version) {
        db.execute(DATABASE_INITIAL_QUERY);
      },
      version: DATABASE_VERSION,
    );
    return database;
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
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      const Text("What am I grateful for right now?", style: kQuestionTextStyle),
      kSizedBox10,
      kSizedBox10,
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
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
      const Text("Other:", style: kQuestionTextStyle),
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

  void _continueClicked() async {
    List<String> selectedOptions = [];
    for (var element in widget.options) {
      if (element.isSelected) {
        selectedOptions.add(element.label);
      }
    }

    String otherText = myController.text;

    if (selectedOptions.isEmpty && otherText.isEmpty) {
      showErrorToast();
      return;
    }

    widget.record?.what_I_am_grateful_for_rn = selectedOptions.toShortString();
    widget.record?.what_I_am_grateful_for_other = otherText;

    database ??= await getDatabase();

    int result = await database?.insert(
          TABLE_NAME,
          widget.record!.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ) ??
        -1;
    print("RESULT: $result");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CompletedScreen()));
  }
}
