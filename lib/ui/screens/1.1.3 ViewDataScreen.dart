import 'dart:convert';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';

class ViewDataScreen extends StatefulWidget {
  List<Record> recods;
  bool isSaveFile = true;

  ViewDataScreen(this.recods, this.isSaveFile, {Key? key}) : super(key: key);

  @override
  State<ViewDataScreen> createState() => _ViewDataScreenState();
}

class _ViewDataScreenState extends State<ViewDataScreen> {
  late PlutoGridStateManager stateManager;

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Date',
      field: Record.strDate,
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Time',
      field: Record.strTime,
      type: PlutoColumnType.time(),
    ),
    PlutoColumn(
      title: 'Sleep: What time did I wake up?',
      field: Record.strWakeUpTime,
      type: PlutoColumnType.time(),
    ),
    PlutoColumn(
      title: 'Sleep: How was the quality of my sleep?',
      field: Record.strQualityOfSleep,
      type: PlutoColumnType.time(),
    ),
    PlutoColumn(
      title: 'Sleep: Quality of my sleep Comments',
      field: Record.strQualityOfSleepComment,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Sleep: What time I did go to sleep?',
      field: Record.strWhatTimeIGoToSleep,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: "Sleep: Total Sleep Time",
      field: Record.strTotalSleepTime,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Sleep: Comment',
      field: Record.strWhatTimeIGoToSleepComment,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What I am doing right now?',
      field: Record.strWhatIAmDoingRightNow,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What I am doing right now?: Comment',
      field: Record.strWhatIAmDoingRightNowComment,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Am I experiencing any physical hunger?',
      field: Record.strIsPhysicalHunger,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Am I experiencing any physical hunger? Option: ',
      field: Record.strIsPhysicalHungerOptions,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Have I eaten?',
      field: Record.strHaveIEaten,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Was it an abstinent meal?',
      field: Record.strEaterWasItAbstinentMeal,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Thirst: Have I consumed any water or tea today?',
      field: Record.strHaveIConsumedAnyWaterOrTea,
      type: PlutoColumnType.text(),
    ),
    // PlutoColumn(
    //   title: 'Thirst: Was it an abstinent meal?',
    //   field: Record.strDrinkWasItAbstinentMeal,
    //   type: PlutoColumnType.text(),
    // ),
    PlutoColumn(
      title: 'What I am feeling right now?',
      field: Record.strWhatIAmFeelingRN,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What I am feeling right now? Other: ',
      field: Record.strWhatIAmFeelingRNOther,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Am I having any food craving right now?',
      field: Record.strFoodCravingRN,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What I am craving right now?',
      field: Record.strFoodCravingRNWhat,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What I am craving right now? Comment',
      field: Record.strFoodCravingRNComment,
      type: PlutoColumnType.text(),
    ),

    PlutoColumn(
      title: 'What I am physically feeling right now?',
      field: Record.strPhysicalFeelingRN,
      type: PlutoColumnType.text(),
    ),

    PlutoColumn(
      title: 'What I am physically feeling right now? Comment',
      field: Record.strPhysicalFeelingRNComment,
      type: PlutoColumnType.text(),
    ),

    PlutoColumn(
      title:
          'Will eating, binging, purging, or restricting food satisfy my emotional needs right now? ',
      field: Record.strFoodAddict,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title:
          'Will eating, binging, purging, or restricting food satisfy my emotional needs right now? Explain',
      field: Record.strFoodAddictExplain,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What do I really want?',
      field: Record.strWhatDoIWant,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What do I really want? Comment:',
      field: Record.strWhatDoIWantComment,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What can I do to get what I really want?',
      field: Record.strWhatCanIDoToGetWhatIWant,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What can I do to get what I really want? Comment: ',
      field: Record.strWhatCanIDoToGetWhatIWantComment,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Have I taken a bathroom break:',
      field: Record.strBathroomBreak,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Have I taken a bathroom break? More Info',
      field: Record.strBathroomBreakMoreInfo,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What am I grateful for right now? ',
      field: Record.strGrateFullForRN,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'What am I grateful for right now? Other',
      field: Record.strGrateFullForOther,
      type: PlutoColumnType.text(),
    ),
  ];

  final List<PlutoRow> rows = [];

  void exportToPdf() async {
    // final themeData = pluto_grid_export.ThemeData.withFont(
    //   base: pluto_grid_export.Font.ttf(
    //     await rootBundle.load('fonts/open_sans/OpenSans-Regular.ttf'),
    //   ),
    //   bold: pluto_grid_export.Font.ttf(
    //     await rootBundle.load('fonts/open_sans/OpenSans-Bold.ttf'),
    //   ),
    // );
    //
    // var plutoGridPdfExport = pluto_grid_export.PlutoGridDefaultPdfExport(
    //   title: "Pluto Grid Sample pdf print",
    //   creator: "Pluto Grid Rocks!",
    //   format: pluto_grid_export.PdfPageFormat.a4.landscape,
    //   themeData: themeData,
    // );
    //
    // await pluto_grid_export.Printing.sharePdf(
    //   bytes: await plutoGridPdfExport.export(stateManager),
    //   filename: plutoGridPdfExport.getFilename(),
    // );
  }

  void exportToCsv() async {
    String title = "mindful_recovery";
    //
    var exported = const Utf8Encoder()
        .convert(pluto_grid_export.PlutoGridExport.exportCSV(stateManager));
    //
    // use file_saver from pub.dev
    var result = await FileSaver.instance
        .saveAs("$title.csv", exported, ".csv", MimeType.CSV);

    print("SAVING RESULTS: $result");
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    widget.recods.forEach((element) {
      rows.add(
        PlutoRow(cells: {
          Record.strDate: PlutoCell(value: element.date),
          Record.strTime: PlutoCell(value: element.time ?? ""),
          Record.strWakeUpTime: PlutoCell(value: element.wake_up_time ?? ""),
          Record.strQualityOfSleep:
              PlutoCell(value: element.quality_of_sleep ?? ""),
          Record.strQualityOfSleepComment:
              PlutoCell(value: element.sleep_comment ?? ""),
          Record.strWhatTimeIGoToSleep:
              PlutoCell(value: element.what_time_I_go_to_sleep ?? ""),
          Record.strTotalSleepTime:
              PlutoCell(value: element.sleepDuration ?? 0),
          Record.strWhatTimeIGoToSleepComment:
              PlutoCell(value: element.what_time_I_go_to_sleep_comment ?? ""),
          Record.strWhatIAmDoingRightNow:
              PlutoCell(value: element.what_I_am_doing_right_now ?? ""),
          Record.strWhatIAmDoingRightNowComment:
              PlutoCell(value: element.what_I_am_doing_right_now_comment ?? ""),

          Record.strIsPhysicalHunger:
              PlutoCell(value: element.is_physical_hunger ?? ""),
          Record.strIsPhysicalHungerOptions:
              PlutoCell(value: element.is_physical_hunger_option ?? ""),

          Record.strHaveIEaten: PlutoCell(value: element.have_I_eaten ?? ""),
          Record.strEaterWasItAbstinentMeal:
              PlutoCell(value: element.eaten_was_it_abstinent ?? ""),

          Record.strHaveIConsumedAnyWaterOrTea:
              PlutoCell(value: element.have_I_consumed_any_water_or_tea ?? ""),
          // Record.strDrinkWasItAbstinentMeal: PlutoCell(value: element.drink_was_it_abstinent ?? ""),

          Record.strWhatIAmFeelingRN:
              PlutoCell(value: element.what_I_am_feeling_rn ?? ""),
          Record.strWhatIAmFeelingRNOther:
              PlutoCell(value: element.what_I_am_feeling_rn_other ?? ""),

          Record.strFoodCravingRN: PlutoCell(value: element.food_craving ?? ""),
          Record.strFoodCravingRNWhat:
              PlutoCell(value: element.food_craving_what ?? ""),
          Record.strFoodCravingRNComment:
              PlutoCell(value: element.food_craving_comment ?? ""),

          Record.strPhysicalFeelingRN:
              PlutoCell(value: element.physical_feeling_rn ?? ""),
          Record.strPhysicalFeelingRNComment:
              PlutoCell(value: element.physical_feeling_rn_comment ?? ""),

          Record.strFoodAddict: PlutoCell(value: element.food_addict ?? ""),
          Record.strFoodAddictExplain:
              PlutoCell(value: element.food_addict_explain ?? ""),

          Record.strWhatDoIWant: PlutoCell(value: element.what_do_I_want ?? ""),
          Record.strWhatDoIWantComment:
              PlutoCell(value: element.what_do_I_want_comment ?? ""),

          Record.strWhatCanIDoToGetWhatIWant:
              PlutoCell(value: element.what_can_I_do_to_get_what_I_want ?? ""),
          Record.strWhatCanIDoToGetWhatIWantComment: PlutoCell(
              value: element.what_can_I_do_to_get_what_I_want_comment ?? ""),

          Record.strBathroomBreak:
              PlutoCell(value: element.bathroom_break ?? ""),
          Record.strBathroomBreakMoreInfo:
              PlutoCell(value: element.bathroom_break_more_info ?? ""),

          Record.strGrateFullForRN:
              PlutoCell(value: element.what_I_am_grateful_for_rn ?? ""),
          Record.strGrateFullForOther:
              PlutoCell(value: element.what_I_am_grateful_for_other ?? ""),
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            kSizedBox10,
            kSizedBox10,
            Expanded(
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (e) {
                  stateManager = e.stateManager;
                },
              ),
            ),
            if (widget.isSaveFile) kSizedBox10,
            if (widget.isSaveFile)
              MyFilledRoundCornerButton(
                label: "Export",
                onButtonClick: exportToCsv,
                horizontalPadding: 0.0,
              ),
          ],
        ),
      ),
    );
  }
}
