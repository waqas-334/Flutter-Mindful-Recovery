import '../data/Record.dart';

const DATABASE_NAME = "my_db.db";
const TABLE_NAME = "DailyRecord";
const DATABASE_INITIAL_QUERY =
    "CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, ${Record.strDate} TEXT, ${Record.strTime} TEXT, ${Record.strWakeUpTime} TEXT, ${Record.strQualityOfSleep} TEXT, ${Record.strQualityOfSleepComment} TEXT, ${Record.strWhatTimeIGoToSleep} TEXT, ${Record.strTotalSleepTime} INTEGER, ${Record.strWhatTimeIGoToSleepComment} TEXT, ${Record.strWhatIAmDoingRightNow} TEXT, ${Record.strWhatIAmDoingRightNowComment} TEXT, ${Record.strIsPhysicalHunger} TEXT, ${Record.strIsPhysicalHungerOptions} TEXT, ${Record.strHaveIEaten} TEXT, ${Record.strEaterWasItAbstinentMeal} TEXT, ${Record.strHaveIConsumedAnyWaterOrTea} TEXT, ${Record.strWhatIAmFeelingRN} TEXT, ${Record.strPhysicalFeelingRNComment} TEXT, ${Record.strWhatIAmFeelingRNOther} TEXT, ${Record.strFoodCravingRN} TEXT, ${Record.strFoodCravingRNWhat} TEXT, ${Record.strFoodCravingRNComment} TEXT, ${Record.strPhysicalFeelingRN} TEXT, ${Record.strFoodAddict} TEXT, ${Record.strFoodAddictExplain} TEXT, ${Record.strWhatDoIWant} TEXT, ${Record.strWhatDoIWantComment} TEXT, ${Record.strWhatCanIDoToGetWhatIWant} TEXT, ${Record.strWhatCanIDoToGetWhatIWantComment} TEXT, ${Record.strBathroomBreak} TEXT, ${Record.strBathroomBreakMoreInfo} TEXT, ${Record.strGrateFullForRN} TEXT, ${Record.strGrateFullForOther} TEXT )";
// "CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, time TEXT, sleep_comment TEXT, quality_of_sleep TEXT, sleep_comment TEXT, what_time_I_go_to_sleep TEXT, what_time_I_go_to_sleep_comment TEXT, what_I_am_doing_right_now TEXT, what_I_am_doing_right_now_comment TEXT, is_physical_hunger TEXT, is_physical_hunger_option TEXT)";
const DATABASE_VERSION = 1;

List<Record> dummy_data = [
  Record(date: DateTime(2022, 12, 1), sleep_comment: "THIS IS FIRST DAY UFF"),
  Record(date: DateTime(2022, 12, 2), sleep_comment: "TH DAY UFF"),
  Record(date: DateTime(2022, 12, 3), sleep_comment: "FIRST DAY UFF"),
  Record(date: DateTime(2022, 12, 4), sleep_comment: "DAY UFF"),
  Record(date: DateTime(2022, 12, 5), sleep_comment: "UFF"),
  Record(date: DateTime(2022, 12, 8), sleep_comment: "THIS"),
  Record(date: DateTime(2022, 12, 10), sleep_comment: "THIS IS"),
  Record(date: DateTime(2022, 12, 15), sleep_comment: "THIS IS FIRST "),
  Record(date: DateTime(2022, 12, 16), sleep_comment: "THIS IS FIRST DAY"),
  Record(date: DateTime(2022, 12, 18), sleep_comment: "THIS IS FIRST  UFF"),
  Record(date: DateTime(2022, 12, 22), sleep_comment: "THIS IS  DAY UFF"),
  Record(date: DateTime(2022, 12, 22), sleep_comment: "THIS FIRST DAY UFF"),
];
