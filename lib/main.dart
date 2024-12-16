import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.pink[100],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink[300],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100],
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
