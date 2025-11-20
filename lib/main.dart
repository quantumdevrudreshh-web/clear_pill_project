import 'package:clear_pill_project/auth/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Color bgColor = Color.fromRGBO(246, 247, 248, 1);

  @override
  Widget build(BuildContext context) {
    return Login(bgColor: bgColor,);
  }
}