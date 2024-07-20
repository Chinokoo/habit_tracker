import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final Function(bool?)? onChanged;
  const HabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!isCompleted),
      child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary),
          child: ListTile(
              leading: Checkbox(
                  activeColor: Colors.green,
                  value: isCompleted,
                  onChanged: onChanged),
              title: Text(
                text,
                style: TextStyle(
                  color: isCompleted
                      ? Colors.white
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ))),
    );
  }
}
