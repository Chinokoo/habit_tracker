import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:habit_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  //run the app
  runApp(MultiProvider(
    providers: [
      //providers
      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      //database provider
      ChangeNotifierProvider(create: (context) => HabitDatabase()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
