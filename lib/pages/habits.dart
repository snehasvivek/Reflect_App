

import 'package:flutter/material.dart';
import 'package:reflect_application/components/habit_block.dart';
import 'package:reflect_application/components/monthly_summary.dart';
import 'package:reflect_application/components/new_habit_block.dart';
import 'package:reflect_application/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/floating_action_button.dart';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({super.key, required this.title});

  final String title;

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTrackerPage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  void habitChecked(bool? v, int i) {
    setState(() {
      db.habits[i][1] = v;
    });
    db.updateDatabase();
  }

  final _newHabitController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return NewHabitBlock(
            controller: _newHabitController,
            onSave: saveNewHabit,
            onCancel: cancelNewHabit,
          );
        });
    db.updateDatabase();
  }

  void saveNewHabit() {
    db.habits.add([_newHabitController.text, false]);
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.habits[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return NewHabitBlock(
            controller: _newHabitController,
            onSave: () => saveExistingHabit(index),
            onCancel: cancelNewHabit,
          );
        });
  }

  void deleteHabit(int index) {
    setState(() {
      db.habits.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingButton(
          onPressed: createNewHabit,
        ),
        body: ListView(
          children: [
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get("START_DATE"),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: db.habits.length,
                itemBuilder: (context, index) {
                  return HabitBlock(
                    habitName: db.habits[index][0],
                    habitCompleted: db.habits[index][1],
                    onChanged: (value) => habitChecked(value, index),
                    settingsTapped: (context) => openHabitSettings(index),
                    deleteTapped: (context) => deleteHabit(index),
                  );
                }),
          ],
        ));
  }
}
