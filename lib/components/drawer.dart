import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HabitDrawer extends StatefulWidget {
  const HabitDrawer({super.key});

  @override
  State<HabitDrawer> createState() => _HabitDrawerState();
}

class _HabitDrawerState extends State<HabitDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      child: Center(
        child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) =>
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ),
    );
  }
}
