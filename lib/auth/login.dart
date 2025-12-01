import 'package:clear_pill_project/auth/login-page.dart';
import 'package:clear_pill_project/auth/reg-page.dart';
import 'package:clear_pill_project/pages/drugscanner.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final Color bgColor;
  const Login({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Color.fromRGBO(246, 247, 248, 1);
    FontWeight weight700 = FontWeight.w700;
    String fontFamily = "Manrope";
    Color fgColor = Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        padding: EdgeInsetsDirectional.all(24),
        color: bgColor,
        child: Column(
          children: <Widget>[
            Spacer(),
            Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: Color.fromRGBO(19, 164, 236, 0.1),
                borderRadius: BorderRadius.circular(9999)
              ),
              child: Icon(Icons.medication_rounded, size: 96, color: Color.fromRGBO(19, 164, 236, 1),),
            ),
        
            Column(
              children: <Widget>[
                Text("Welcome to Pill Identifier\n", style: TextStyle(fontWeight: weight700, color: Color.fromRGBO(15, 23, 42, 1), fontSize: 36, fontFamily: fontFamily), textAlign: TextAlign.center),
                Text("Scan your pills to get detailed information about them instantly. Your personal medication assistant.", style: TextStyle(color: Color.fromRGBO(71, 85, 105, 1), fontFamily: fontFamily), textAlign: TextAlign.center,)
              ],
            ),

            Spacer(),
        
            SizedBox(height: 24,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage(bgColor: bgColor, fontFamily: fontFamily, weight700: weight700)));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(19, 164, 236, 1), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text("Log In", style: TextStyle(fontFamily: fontFamily, color: fgColor, fontWeight: weight700, fontSize: 18, height: 1.75),),
                ),
              ),
            ),
            SizedBox(height: 24,),
        
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(bgColor: bgColor, fontFamily: fontFamily, weight700: weight700)));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100], 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text("Register", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(19, 164, 236, 1), fontWeight: weight700, fontSize: 18, height: 1.75),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
