import 'package:clear_pill_project/auth/login.dart';
import 'package:clear_pill_project/pages/drugscanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  // 1. Required for async code in main
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Load the Shared Preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // 3. Check the saved boolean (default to false if key doesn't exist)

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // 4. Run the app, passing the status
  runApp(
    MaterialApp(
      home: MyApp(startHome: isLoggedIn,),
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatelessWidget {
  final bool startHome;
  MyApp({super.key, required this.startHome});
  Color bgColor = Color.fromRGBO(246, 247, 248, 1);

  @override
  Widget build(BuildContext context) {
    return startHome ? Drugscanner(bgColor: bgColor) : Login(bgColor: bgColor);
  }
}