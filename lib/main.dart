import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kinoqahramon_firebase/screens/home/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breaking Bad',
      home: HomePage(),
    );
  }
}
