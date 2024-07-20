import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker/components/drawer.dart';
import 'package:habit_tracker/components/habit_list.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //The first time a user opens the app,
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

  //creating a textfield controller
  final TextEditingController _controller = TextEditingController();

  //creating a habit dialog
  void createHabitDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "Create a new Habit",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary))),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    //pop the dialog
                    Navigator.pop(context);

                    //clear the textfield
                    _controller.clear();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    String newHabitName = _controller.text;
                    //save to database,
                    context.read<HabitDatabase>().addHabit(newHabitName);

                    //pop the dialog
                    Navigator.pop(context);

                    //clear the textfield
                    _controller.clear();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          //foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        drawer: const HabitDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createHabitDialog(),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        body: Column(
          children: [
            Text(
              "To Edit or Delete Habit, Slide the Habit Tile to The Left.",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: HabitList(),
            )
          ],
        ));
  }
}
