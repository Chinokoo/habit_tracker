import 'package:flutter/material.dart';
import 'package:habit_tracker/components/heatmap_data.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/utils/habit_util.dart';
import 'package:provider/provider.dart';

class HeatMap extends StatefulWidget {
  const HeatMap({super.key});

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {
  @override
  Widget build(BuildContext context) {
    // habit database.
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits.
    List<Habit> currentHabits = habitDatabase.currentHabits;

    return FutureBuilder<DateTime?>(
        future: habitDatabase.getFirstLaunchDate(),
        builder: (context, snapshot) {
          //once the data is available => build the heat map.
          if (snapshot.hasData) {
            return HeatMapData(
                datasets: prepHeatMapDataset(currentHabits),
                startDate: snapshot.data!);
          }
          // handle the case where no data is returned.
          else {
            return Container();
          }
        });
  }
}
