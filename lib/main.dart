import 'package:ff_demo/constants.dart';
import 'package:ff_demo/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FF Demo',
      theme: ThemeData(
        primaryColor: themeLightBlueColor,
        accentColor: themeDarkBlueColor,
        scaffoldBackgroundColor: scaffoldBGColor,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: themeLightBlueColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffd0d3e2),
            onPrimary: themeDarkBlueColor,
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            elevation: 4,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
