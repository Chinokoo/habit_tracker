import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

// I N I T I A L I Z E D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

//*save first date of app start up for heat map.
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

//*get first date of app start up for heat map.
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

// C R U D  O P E R A T I O N S

//* List of Habits
  final List<Habit> currentHabits = [];

//*create a new habit
  Future<void> addHabit(String habit) async {
    //create a new habit.
    final newHabit = Habit()..name = habit;
    //add the new habit to the database.
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //re-read from the db
    readHabits();
  }

//*read a habit
  Future<void> readHabits() async {
    //fetch all habits from the database.

    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    //give the current habits.
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);
    //notify listeners which updates the UI.
    notifyListeners();
  }

//*update an existing habit
//? update check on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    //find the habit with the given id.
    final habit = await isar.habits.get(id);

    //update completion status.
    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          //add the current date to the completed days list.
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
          //add the c
        }
        //if habit is not completed, remove the current date from the completed days list.
        else {
          //remove the current date from the completed days list.
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        // save the updated habits back to the db.
        await isar.habits.put(habit);
      });
    }
    //re-read from the db
    readHabits();
  }

//? update habit name
  Future<void> updateHabitName(int id, String newName) async {
    //find the habit with the given id.
    final habit = await isar.habits.get(id);

    //update the habit name.
    if (habit != null) {
      //update the habit name.
      await isar.writeTxn(() async {
        habit.name = newName;
        // save the updated habit back to the db.
        await isar.habits.put(habit);
      });
    }
    //re-read from the db
    readHabits();
  }

//*delete a habit
  Future<void> deleteHabit(int id) async {
    //perform the delete operation.
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    //re-read from the db
    readHabits();
  }
}
