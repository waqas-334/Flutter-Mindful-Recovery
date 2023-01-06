import 'package:flutter/material.dart';
import 'package:flutter_mindful_recovery/ui/const/Constants.dart';
import 'package:flutter_mindful_recovery/ui/util/DB.dart';
import 'package:flutter_mindful_recovery/ui/util/Extensions.dart';
import 'package:flutter_mindful_recovery/ui/widgets/ButtonBack.dart';
import 'package:flutter_mindful_recovery/ui/widgets/container/MainContainer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

import '../data/Record.dart';
import '../widgets/FilledRoundCornerButton.dart';
import '1.1.3 ViewDataScreen.dart';

class ViewDataSelectionScreen extends StatefulWidget {
  bool isExport = false;

  ViewDataSelectionScreen(this.isExport, {Key? key}) : super(key: key);

  @override
  State<ViewDataSelectionScreen> createState() =>
      _ViewDataSelectionScreenState();
}

class _ViewDataSelectionScreenState extends State<ViewDataSelectionScreen> {
  Database? database;

  DateTime? databaseStartDate; //to pass to the calender
  DateTime? databaseEndDate; //to pass to the calender

  DateTime? userSelectedStartDate; //to get data from db
  DateTime? userSelectedEndDate; //to get data from db

  var isError = false;

  // String startDateString = "Select Date";
  // String endDateString = "Select Date";
  // String recordsFound = "0 Records Found";
  // List<Record>? databaseListRecord;

  @override
  void initState() {
    super.initState();
    getDatabase();
  }

  void getDatabase() async {
    //print("DATE TIME IN ISO :${DateTime.now().toIso8601String()}"); //2022-12-30T09:49:22.982083
    database = await openDatabase(DATABASE_NAME);
    // var dbListMap = await database
    //     ?.rawQuery("SELECT * FROM $TABLE_NAME ORDER BY date ASC ");
    try {
      var bottomDate = await database
          ?.rawQuery("SELECT MIN(date) as min_date FROM $TABLE_NAME");

      var topDate = await database
          ?.rawQuery("SELECT MAX(date) as max_date FROM $TABLE_NAME");

      databaseStartDate =
          DateTime.tryParse(bottomDate?.first["min_date"] as String);
      databaseEndDate = DateTime.tryParse(topDate?.first["max_date"] as String);
    } on DatabaseException {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      appBar: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          kBackButton,
          Expanded(
            flex: 20,
            child: Center(
              child: Text(
                widget.isExport ? "Export Data" : "View Data",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      children: [
        if (isError) ...[
          const Expanded(child: Center(child: Text("No Data Recorded")))
        ] else ...[
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          Text("Start Date"),
          kSizedBox10,
          kSizedBox10,
          GestureDetector(
            onTap: onStartDateClicked,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Colors.blue)),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    userSelectedStartDate?.toReadableString() ??
                        "Select Start Date",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          kSizedBox10,
          if (userSelectedStartDate != null) Text("End Date"),
          kSizedBox10,
          kSizedBox10,
          if (userSelectedStartDate != null)
            GestureDetector(
              onTap: onEndDateClicked,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.blue)),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      userSelectedEndDate?.toReadableString() ??
                          "Select End Date",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
          const Spacer(),
          if (userSelectedEndDate != null && userSelectedStartDate != null)
            FutureBuilder<List<Record>>(
              future: getRecordFromDB(
                  userSelectedStartDate!, userSelectedEndDate!, database!),
              builder: (context, snapshot) => Center(
                  child: Text("${snapshot.data?.length ?? "0"} records found")),
            ),
          kSizedBox10,
          kSizedBox10,
          GestureDetector(
            onLongPress: _onLongPressed,
            child: MyFilledRoundCornerButton(
              label: widget.isExport ? "View and Export" : "View",
              onButtonClick: _onViewClicked,
              horizontalPadding: 0.0,
            ),
          ),
        ]
      ],
    );
  }

  //
  // String _getNumberOfRecords() {
  //   var records = getRecords(
  //       userSelectedStartDate!, userSelectedEndDate!, databaseListRecord!);
  //
  //   return "${records.length} Records Found";
  // }

  List<Record>? queryAppliedRecords;

  Future<List<Record>> getRecordFromDB(
      DateTime startDate, DateTime endDate, Database database) async {
    var dbListMaInDateRange = await database.rawQuery(
        "SELECT * FROM $TABLE_NAME WHERE date BETWEEN ${startDate.toYYYYMMDDformat()} AND ${endDate.toYYYYMMDDformat()}");
    print(("DATABASE QUERY: ${dbListMaInDateRange.length}"));
    var data = dbListMaInDateRange.map((e) {
      print("CONVERTING: ${e[Record.strTime]}");
      Record converted = Record.fromMap(e);
      print("CONVERTED: ${converted.time}");
      return converted;
    }).toList();
    print("DATA AFTER CONVERSION: ${data.length}");
    queryAppliedRecords = data;
    return data;
  }

  void _onViewClicked() async {
    //DB QUERY: https://stackoverflow.com/questions/1975737/sqlite-datetime-comparison
    queryAppliedRecords ??= await getRecordFromDB(
        userSelectedStartDate!, userSelectedEndDate!, database!);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ViewDataScreen(queryAppliedRecords!, widget.isExport)));

    return;
    /*

     /**
     * This will
     * 1. First get first index of the @[userSelectedStartDate] from @[databaseListRecord]
     *    if there is no record on the given date then it will check for the next date
     *    and so on, until it finds the data whois record is in the database or the end date arrives
     */


    if (userSelectedStartDate == null) {
      Fluttertoast.showToast(
        msg: "Please select start date",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }
    if (userSelectedEndDate == null) {
      Fluttertoast.showToast(
        msg: "Please select end date",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
      );
      return;
    }

    var startIndex = databaseListRecord?.indexWhere(
        (element) => element.date == userSelectedStartDate?.toIso8601String());
    int daysToAdd = 0;
    var newStartDate = userSelectedStartDate!;
    while (startIndex == -1 && newStartDate.isBefore(userSelectedEndDate!)) {
      newStartDate = userSelectedStartDate!.add(Duration(days: daysToAdd++));
      print("WHILE START INDEX: $startIndex");
      print("WHILE New Date: ${newStartDate.toReadableString()}");
      startIndex = databaseListRecord?.indexWhere(
          (element) => element.date == newStartDate.toIso8601String());
    }

    //if startIndex is still -1 it means there is no record between the start and end date
    print("START INDEX AFTER WHILE: $startIndex");

    var endIndex = databaseListRecord?.lastIndexWhere(
        (element) => element.date == userSelectedEndDate?.toIso8601String());

    int daysToSubtract = 0;
    var newEndDate = userSelectedEndDate!;
    while (endIndex == -1 && newEndDate.isAfter(userSelectedStartDate!)) {
      newEndDate =
          userSelectedEndDate!.subtract(Duration(days: daysToSubtract++));
      print("NEW END DATE: $newEndDate");
      endIndex = databaseListRecord?.lastIndexWhere(
          (element) => element.date == newEndDate.toIso8601String());
    }

    print("END INDEX AFTER WHILE: $endIndex");

    print("START INDEX DATA: ${databaseListRecord![startIndex!].wake_up_time}");
    print("END INDEX DATA: ${databaseListRecord![endIndex!].wake_up_time}");
    print("START INDEX: $startIndex\n\nEndIndex: $endIndex");*/
  }

/*

  List<Record> getRecords(
      DateTime startDate, DateTime endDate, List<Record> databaseToFindFrom) {
    var startIndex = getStartIndex(startDate, endDate, databaseToFindFrom);
    if (startIndex == -1) {
      //This means there is no data between startDate and endDate
      return [];
    }
    var endIndex = getEndIndex(startDate, endDate, databaseToFindFrom);
    if (endIndex == -1) {
      //Even though this is not necessary, but still just in case
      //This means there is no data between startDate and endDate
      return [];
    }

    return databaseToFindFrom.getRange(startIndex, endIndex).toList();
  }

  int getStartIndex(
      DateTime startDate, DateTime endDate, List<Record> databaseToFindFrom) {
    var startIndex = databaseToFindFrom
        .indexWhere((element) => element.date == startDate.toIso8601String());

    if (startIndex != -1) return startIndex;

    int daysToAdd = 0;
    var newStartDate = startDate;
    while (startIndex == -1 && newStartDate.isBefore(endDate)) {
      newStartDate = startDate.add(Duration(days: daysToAdd++));
      print("WHILE START INDEX: $startIndex");
      print("WHILE New Date: ${newStartDate.toReadableString()}");
      startIndex = databaseToFindFrom.indexWhere(
          (element) => element.date == newStartDate.toIso8601String());
    }
    return startIndex;
  }

  int getEndIndex(
      DateTime startDate, DateTime endDate, List<Record> databaseToFindFrom) {
    /// This will find the last index of [endDate] in databaseToFindFrom
    /// if there is record on the endData in database, then return the index
    /// otherwise:
    ///   reduce one day
    ///     and check if that new day is after the [startDate] and there is a record on that day
    ///       if no then repeat, until there is a record on new days or the new day is not after startDate
    ///

    var endIndex = databaseToFindFrom
        .lastIndexWhere((element) => element.date == endDate.toIso8601String());

    if (endIndex != -1) {
      //This means that whatever user selected, there is a record against that date
      return endIndex;
    }

    int daysToSubtract = 0;
    var newEndDate = endDate;
    while (endIndex == -1 && newEndDate.isAfter(startDate)) {
      newEndDate = endDate.subtract(Duration(days: daysToSubtract++));
      print("NEW END DATE: $newEndDate");
      endIndex = databaseToFindFrom.lastIndexWhere(
          (element) => element.date == newEndDate.toIso8601String());
    }
    return endIndex;
  }
*/

  void _onLongPressed() {
    print("VIEW CLIKCED");
    var route = MaterialPageRoute(
      builder: (_) => const DatabaseList(),
    );
    Navigator.of(context).push(route);
  }

  void onStartDateClicked() async {
    DateTime? datetime = await showDatePicker(
        context: context,
        initialDate: databaseStartDate!,
        firstDate: databaseStartDate!,
        lastDate: databaseEndDate!);
    if (datetime == null) return;
    setState(() {
      userSelectedStartDate = datetime;
      userSelectedEndDate = null;
    });
  }

  void onEndDateClicked() async {
    // var dateRange = showDateRangePicker(
    //     context: context,
    //     initialDateRange:
    //         DateTimeRange(start: databaseStartDate!, end: databaseEndDate!),
    //     firstDate: databaseStartDate!,
    //     lastDate: databaseEndDate!);

    DateTime? datetime = await showDatePicker(
        context: context,
        initialDate: databaseEndDate!,
        firstDate: userSelectedStartDate!,
        lastDate: databaseEndDate!);

    if (datetime == null) return;
    setState(() {
      userSelectedEndDate = datetime;
    });
  }
}
