import '../util/Extensions.dart';
import '../util/MyTimeOfDay.dart';

class Record {
  static const strDate = "date";
  static const strTime = "time";

  static const strWakeUpTime = "wake_up_time";
  static const strQualityOfSleep = "quality_of_sleep";
  static const strQualityOfSleepComment = "sleep_comment";

  static const strWhatTimeIGoToSleep = "what_time_I_go_to_sleep";
  static const strTotalSleepTime = "total_sleep_time";
  static const strWhatTimeIGoToSleepComment = "what_time_I_go_to_sleep_comment";

  static const strWhatIAmDoingRightNow = "what_I_am_doing_right_now";
  static const strWhatIAmDoingRightNowComment =
      "what_I_am_doing_right_now_comment";

  static const strIsPhysicalHunger = "is_physical_hunger";
  static const strIsPhysicalHungerOptions = "is_physical_hunger_option";

  static const strHaveIEaten = "have_I_eaten";
  static const strEaterWasItAbstinentMeal = "eaten_was_it_abstinent";

  static const strHaveIConsumedAnyWaterOrTea =
      "have_I_consumed_any_water_or_tea";
  // static const strDrinkWasItAbstinentMeal = "drink_was_it_abstinent";

  static const strWhatIAmFeelingRN = "what_I_am_feeling_rn";
  static const strWhatIAmFeelingRNOther = "what_I_am_feeling_rn_other";

  static const strFoodCravingRN = "food_craving";
  static const strFoodCravingRNWhat = "food_craving_what";
  static const strFoodCravingRNComment = "food_craving_comment";

  static const strPhysicalFeelingRN = "physical_feeling_rn";
  static const strPhysicalFeelingRNComment = "physical_feeling_rn_comment";

  static const strFoodAddict = "food_addict";
  static const strFoodAddictExplain = "food_addict_explain";

  static const strWhatDoIWant = "what_do_I_want";
  static const strWhatDoIWantComment = "what_do_I_want_comment";

  static const strWhatCanIDoToGetWhatIWant = "what_can_I_do_to_get_what_I_want";
  static const strWhatCanIDoToGetWhatIWantComment =
      "what_can_I_do_to_get_what_I_want_comment";

  static const strBathroomBreak = "bathroom_break";
  static const strBathroomBreakMoreInfo = "bathroom_break_more_info";

  static const strGrateFullForRN = "what_I_am_grateful_for_rn";
  static const strGrateFullForOther = "what_I_am_grateful_for_other";

  DateTime? date;
  MyTimeOfDay? time;

  MyTimeOfDay? wake_up_time;
  String? quality_of_sleep;
  String? sleep_comment;

  MyTimeOfDay? what_time_I_go_to_sleep;
  int? sleepDuration; //saves sleep duration in minutes
  String? what_time_I_go_to_sleep_comment;

  String? what_I_am_doing_right_now;
  String? what_I_am_doing_right_now_comment;

  String? is_physical_hunger;
  String? is_physical_hunger_option;

  String? have_I_eaten;
  String? eaten_was_it_abstinent;

  String? have_I_consumed_any_water_or_tea;
  String? drink_was_it_abstinent;

  String? what_I_am_feeling_rn;
  String? what_I_am_feeling_rn_other;

  String? food_craving;
  String? food_craving_what;
  String? food_craving_comment;

  String? physical_feeling_rn;
  String? physical_feeling_rn_comment;

  String? food_addict;
  String? food_addict_explain;

  String? what_do_I_want;
  String? what_do_I_want_comment;

  String? what_can_I_do_to_get_what_I_want;
  String? what_can_I_do_to_get_what_I_want_comment;

  String? bathroom_break;
  String? bathroom_break_more_info;

  String? what_I_am_grateful_for_rn;
  String? what_I_am_grateful_for_other;

  Record({
    this.date,
    this.time,
    this.wake_up_time,
    this.quality_of_sleep,
    this.sleep_comment,
    this.what_time_I_go_to_sleep,
    this.sleepDuration,
    this.what_time_I_go_to_sleep_comment,
    this.what_I_am_doing_right_now,
    this.what_I_am_doing_right_now_comment,
    this.is_physical_hunger,
    this.is_physical_hunger_option,
    this.have_I_eaten,
    this.eaten_was_it_abstinent,
    this.have_I_consumed_any_water_or_tea,
    this.drink_was_it_abstinent,
    this.what_I_am_feeling_rn,
    this.what_I_am_feeling_rn_other,
    this.food_craving,
    this.food_craving_what,
    this.food_craving_comment,

    this.physical_feeling_rn,
    this.physical_feeling_rn_comment,

    this.food_addict,
    this.food_addict_explain,
    this.what_do_I_want,
    this.what_do_I_want_comment,
    this.what_can_I_do_to_get_what_I_want,
    this.what_can_I_do_to_get_what_I_want_comment,
    this.bathroom_break,
    this.bathroom_break_more_info,
    this.what_I_am_grateful_for_rn,
    this.what_I_am_grateful_for_other,
  });

  Map<String, dynamic> toMap() {
    return {
      strDate: date?.toYYYYMMDDformat(),
      strTime: time?.toString(),
      strWakeUpTime: wake_up_time?.toString(),
      strQualityOfSleep: quality_of_sleep,
      strQualityOfSleepComment: sleep_comment,
      strWhatTimeIGoToSleep: what_time_I_go_to_sleep?.toString(),
      strWhatTimeIGoToSleepComment: what_time_I_go_to_sleep_comment,
      strWhatIAmDoingRightNow: what_I_am_doing_right_now,
      strTotalSleepTime: sleepDuration,
      strWhatIAmDoingRightNowComment: what_I_am_doing_right_now_comment,
      strIsPhysicalHunger: is_physical_hunger,
      strIsPhysicalHungerOptions: is_physical_hunger_option,
      strHaveIEaten: have_I_eaten,
      strEaterWasItAbstinentMeal: eaten_was_it_abstinent,
      strHaveIConsumedAnyWaterOrTea: have_I_consumed_any_water_or_tea,
      // strDrinkWasItAbstinentMeal: drink_was_it_abstinent,
      strWhatIAmFeelingRN: what_I_am_feeling_rn,
      strPhysicalFeelingRNComment: physical_feeling_rn_comment,

      strWhatIAmFeelingRNOther: what_I_am_feeling_rn_other,
      strFoodCravingRN: food_craving,
      strFoodCravingRNWhat: food_craving_what,
      strFoodCravingRNComment: food_craving_comment,
      strPhysicalFeelingRN: physical_feeling_rn,
      strFoodAddict: food_addict,
      strFoodAddictExplain: food_addict_explain,
      strWhatDoIWant: what_do_I_want,
      strWhatDoIWantComment: what_do_I_want_comment,
      strWhatCanIDoToGetWhatIWant: what_can_I_do_to_get_what_I_want,
      strWhatCanIDoToGetWhatIWantComment:
          what_can_I_do_to_get_what_I_want_comment,
      strBathroomBreak: bathroom_break,
      strBathroomBreakMoreInfo: bathroom_break_more_info,
      strGrateFullForRN: what_I_am_grateful_for_rn,
      strGrateFullForOther: what_I_am_grateful_for_other,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      date: (map[strDate] as String?)?.fromYYYYMMDD(),
      time: (map[strTime] as String?)?.toTimeOfDay(),
      wake_up_time: (map[strWakeUpTime] as String?)?.toTimeOfDay(),
      quality_of_sleep: map[strQualityOfSleep],
      sleep_comment: map[strQualityOfSleepComment],
      what_time_I_go_to_sleep:
          (map[strWhatTimeIGoToSleep] as String?)?.toTimeOfDay(),
      what_time_I_go_to_sleep_comment: map[strWhatTimeIGoToSleepComment],
      what_I_am_doing_right_now: map[strWhatIAmDoingRightNow],
      sleepDuration: map[strTotalSleepTime],
      what_I_am_doing_right_now_comment: map[strWhatIAmDoingRightNowComment],
      is_physical_hunger: map[strIsPhysicalHunger],
      is_physical_hunger_option: map[strIsPhysicalHungerOptions],
      have_I_eaten: map[strHaveIEaten],
      eaten_was_it_abstinent: map[strEaterWasItAbstinentMeal],
      have_I_consumed_any_water_or_tea: map[strHaveIConsumedAnyWaterOrTea],
      // drink_was_it_abstinent: map[strDrinkWasItAbstinentMeal],

      what_I_am_feeling_rn: map[strWhatIAmFeelingRN],
      physical_feeling_rn_comment: map[strPhysicalFeelingRNComment] ,

      what_I_am_feeling_rn_other: map[strWhatIAmFeelingRNOther],
      food_craving: map[strFoodCravingRN],
      food_craving_what: map[strFoodCravingRNWhat],
      food_craving_comment: map[strFoodCravingRNComment],
      physical_feeling_rn: map[strPhysicalFeelingRN],
      food_addict: map[strFoodAddict],
      food_addict_explain: map[strFoodAddictExplain],
      what_do_I_want: map[strWhatDoIWant],
      what_do_I_want_comment: map[strWhatDoIWantComment],
      what_can_I_do_to_get_what_I_want: map[strWhatCanIDoToGetWhatIWant],
      what_can_I_do_to_get_what_I_want_comment:
          map[strWhatCanIDoToGetWhatIWantComment],
      bathroom_break: map[strBathroomBreak],
      bathroom_break_more_info: map[strBathroomBreakMoreInfo],
      what_I_am_grateful_for_rn: map[strGrateFullForRN],
      what_I_am_grateful_for_other: map[strGrateFullForOther],
    );
  }

  @override
  String toString() {
    var string =
        "Date: $date\nTime: $time\nWake up Time: $wake_up_time\nQuality of sleep: $quality_of_sleep\nSleep comment: $sleep_comment";
    return string;
  }
}
