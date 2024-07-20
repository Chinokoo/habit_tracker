import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatefulWidget {
  final bool isCompleted;
  final String text;
  final Function(bool?)? onChanged;
  final Function()? editHabit;
  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.editHabit,
  });

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: (context) => widget.editHabit?.call(),
          backgroundColor: Colors.blue,
          icon: Icons.edit,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ]),
      child: GestureDetector(
        onTap: () => widget.onChanged?.call(!widget.isCompleted),
        child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: widget.isCompleted
                    ? const Color.fromARGB(255, 58, 160, 62)
                    : Theme.of(context).colorScheme.secondary),
            child: ListTile(
                leading: Checkbox(
                    activeColor: Colors.green,
                    value: widget.isCompleted,
                    onChanged: widget.onChanged),
                title: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.isCompleted
                        ? Colors.white
                        : Theme.of(context).colorScheme.inversePrimary,
                  ),
                ))),
      ),
    );
  }
}
