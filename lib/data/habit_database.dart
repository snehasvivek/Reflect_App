import 'package:hive_flutter/hive_flutter.dart';
import 'package:reflect_application/datetime/date_time.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List habits = [];
  Map<DateTime, int> heatMapDataSet = {};

  // creates initial data
  void createDefaultData() {
    habits = [
      ["bake bed", false],
      ["read a book", false],
      ["take a walk", false],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load exiting data
  void loadData() {
    // new day
    if (_myBox.get(todaysDateFormatted()) == null) {
      habits = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < habits.length; i++) {
        habits[i][1] = false;
      }
    }
    // not a new day
    else {
      habits = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    //update today's entry
    _myBox.put(todaysDateFormatted(), habits);
    //update universal habit list
    _myBox.put("CURRENT_HABIT_LIST", habits);

    calculateHabitPercentages();
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < habits.length; i++) {
      if (habits[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = habits.isEmpty
        ? '0.0'
        : (countCompleted / habits.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));
    int daysInBetween = DateTime.now().difference(startDate).inDays;
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDataTimeToString(startDate.add(Duration(days: i)));

      double strength = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength).toInt(),
      };
      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
