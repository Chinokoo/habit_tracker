import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/utils/habit_util.dart';
import 'package:provider/provider.dart';

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    //habit database
    final habitDatabase = context.watch<HabitDatabase>();

    // current habits
    List<Habit> currenthabits = habitDatabase.currentHabits;

    //check the habit on and off.
    void checkHabitOnAndOff(bool? value, Habit habit) {
      //update the habit in the database
      if (value != null) {
        context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
      }
    }

    //editing the habit.
    editHabit(Habit habit) {
      TextEditingController _controller =
          TextEditingController(text: habit.name);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Edit This Habit"),
                content: TextField(
                  controller: _controller,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      //pop the dialog.
                      Navigator.pop(context);
                      //clear the text field.
                      _controller.clear();
                    },
                    child: const Text("Cancel"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      context
                          .read<HabitDatabase>()
                          .updateHabitName(habit.id, _controller.text);
                      //pop the dialog.
                      Navigator.pop(context);
                      //clear the text field.
                      _controller.clear();
                    },
                    child: const Text("Save"),
                  ),
                ],
              ));
    }

    return ListView.builder(
      itemCount: currenthabits.length,
      itemBuilder: (context, index) {
        //get individual habit
        final habit = currenthabits[index];

        //check if the habit is competed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        // return habit tile UI;
        return HabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnAndOff(value, habit),
          editHabit: () => editHabit(habit),
        );
      },
    );
  }
}
