import 'package:shared_preferences/shared_preferences.dart';

const OPEN_COUNTER_KEY = "open_counter";

class MySharedPrefs {
  SharedPreferences? prefs;

  MySharedPrefs() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      print("GOT SHARED PREFS: $prefs");
    });
  }

  Future<int> getCounter() async {
    var openCounter = prefs?.getInt(OPEN_COUNTER_KEY);
    var counter = openCounter ?? 0;
    // print("COUNTER: $counter");
    return counter;
  }

  void increaseOpenCounter() async {
    var currentCounter = prefs?.getInt(OPEN_COUNTER_KEY) ?? 1;
    print("Counter in increase counter: $currentCounter");
    currentCounter = currentCounter+1;
    prefs?.setInt(OPEN_COUNTER_KEY, currentCounter).then((value) {
      print("THEN $value");
    })??{
      print("PREFS ARE NULL")
    };
  }

  Future<bool> isFirstOpen() async {
    return (await getCounter()) == 1;
  }
}
