import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit {
  //habit id
  Id id = Isar.autoIncrement;

  //habit name;
  late String name;

  //completed days -eg DateTime(year, month, day) => DateTime(2022, 1, 1)
  List<DateTime> completedDays = [];
}
