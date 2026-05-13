import 'package:flutter/material.dart';
import 'package:what2cook/pages/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      routes: {
        'home': (context) => Homepage(),
      },
      theme: ThemeData(
        fontFamily: 'Poppins',

      ),
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
    ),
  );
}

