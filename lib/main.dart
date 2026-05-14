import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:what2cook/pages/Wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',

      ),
      home: Wrapper(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

