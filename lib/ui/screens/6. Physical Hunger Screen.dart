import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/data/Record.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../util/DB.dart';
import '../util/Extensions.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '7. EatenScreen.dart';

enum YesOrNo { YES, NO }

class PhysicalHunger extends StatefulWidget {
  Record? record;

  PhysicalHunger(this.record, {Key? key}) : super(key: key);

  @override
  State<PhysicalHunger> createState() => _PhysicalHungerState();
}

class _PhysicalHungerState extends State<PhysicalHunger> {
  YesOrNo? isPhysicalHungary = null;

  List<String> get _options {
    return ["Very Hungary", "A Little Hungary", "Hungary"];
  }

  late String selectedValue;
  // Database? database;

  @override
  void initState() {
    super.initState();
    selectedValue = _options[0];
    // getDatabase().then((value) {
    //   database = value;
    //   print("RETRIVED DATABASE");
    // });
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

  @override
  Widget build(BuildContext context) {
    return MainContainer(children: [
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      kSizedBox10,
      Text("Am I experiencing any Physical Hunger?", style: kQuestionTextStyle),
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
      GestureDetector(
        onLongPress: _onLongPressed,
        child: MyFilledRoundCornerButton(
          label: "Continue",
          onButtonClick: _continueClicked,
          horizontalPadding: 0.0,
        ),
      ),
    ]);
  }

  void onRadioChanged(YesOrNo? value) {
    if (value == null) return;
    setState(() {
      isPhysicalHungary = value;
    });
  }

  void _onLongPressed() async {
    final database = await openDatabase(DATABASE_NAME);
    for (var element in dummy_data) {
      var key = await database.insert(TABLE_NAME, element.toMap());
      print("INSERT ROW: $key");
    }
  }

  void _continueClicked() async {
    if (isPhysicalHungary == null) {
      Fluttertoast.showToast(
        msg: "Please select one option",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }


    widget.record?.is_physical_hunger = isPhysicalHungary?.toShortString();
    widget.record?.is_physical_hunger_option = selectedValue;

    //
    // database ??= await getDatabase();
    //
    // print("DATABASE IS OPEN: ${database?.isOpen}");

    // int result = await database?.insert(
    //       TABLE_NAME,
    //       widget.record!.toMap(),
    //       conflictAlgorithm: ConflictAlgorithm.replace,
    //     ) ??
    //     -1;

    // print("INSERTION INT: $result");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EatenScreen(widget.record)));
  }
}
