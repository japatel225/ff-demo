import 'package:ff_demo/constants.dart';
import 'package:ff_demo/presentation/screens/home_screen.dart';
import 'package:ff_demo/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : HomeScreen(),
    );
  }
}
