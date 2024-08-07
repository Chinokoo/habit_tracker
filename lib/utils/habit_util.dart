//given a list of completion days
// is the habit completed today?

import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

//prepare heat map dataset.
Map<DateTime, int> prepHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      //normalize date to avoid time mismatch.
      final normalizeDate = DateTime(date.year, date.month, date.day);

      //if the date already exists in the dataset, increment the count.
      if (dataset.containsKey(normalizeDate)) {
        dataset[normalizeDate] = dataset[normalizeDate]! + 1;
      } else {
        //else initialize the count to 1.
        dataset[normalizeDate] = 1;
      }
    }
  }

  return dataset;
}
