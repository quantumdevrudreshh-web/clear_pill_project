import 'package:clear_pill_project/auth/login-page.dart';
import 'package:clear_pill_project/pages/drugscanner.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final Color bgColor;
  final String fontFamily;
  final FontWeight weight700;
  const RegisterPage({super.key, required this.bgColor, required this.fontFamily, required this.weight700});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: TextStyle(fontWeight: weight700, fontFamily: fontFamily, fontSize: 18, height: 1.75),),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(24),
        child: LoginCredentials(fontFamily: fontFamily, weight700: weight700, bgColor: bgColor,),
      ),
    );
  }
}

class LoginCredentials extends StatelessWidget {
  final String fontFamily;
  final FontWeight weight700;
  final Color bgColor;
  const LoginCredentials({super.key, required this.fontFamily, required this.weight700, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Spacer(),
        CreateYourAccountText(fontFamily: fontFamily, weight700: weight700),
        SizedBox(height: 40,),
        UserNameTextField(fontFamily: fontFamily,),
        SizedBox(height: 24,),
        PasswordTextField(fontFamily: fontFamily),
        SizedBox(height: 24,),
        ConfirmPasswordTextField(fontFamily: fontFamily),
        SizedBox(height: 24,),
        BottomSignUpButton(weight700: weight700, fontFamily: fontFamily, bgColor: bgColor,),
        Spacer(),
        AlreadyHaveAccount(fontFamily: fontFamily, bgColor: bgColor,),
        SizedBox(height: 24,),
      ],
    );
  }
}

class CreateYourAccountText extends StatelessWidget {
  final String fontFamily;
  final FontWeight weight700;
  const CreateYourAccountText({super.key, required this.fontFamily, required this.weight700});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Create your account\n",
        style: TextStyle(fontFamily: fontFamily, fontWeight: weight700, fontSize: 30, height: 2.25, color: Color.fromRGBO(17, 24, 39, 1)),
        children: <InlineSpan> [
          TextSpan(
            text: "Join us to get started",
            style: TextStyle(color: Color.fromRGBO(75, 85, 99, 1), fontSize: 16, height: 1.5, fontWeight: FontWeight.normal)
          )
        ]
      )
    );
  }
}

class UserNameTextField extends StatelessWidget {
  final String fontFamily;
  const UserNameTextField({super.key, required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        // 1. Labels and Hints
        labelText: 'Username or Email',
        //hintText: 'Enter your unique username',
        //helperText: 'Must be at least 6 characters',

        //Styles
        labelStyle: TextStyle(height: 3.5, fontFamily: fontFamily),
        
        // 2. Icons
        prefixIcon: const Icon(Icons.person),
        //suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
        
        // 3. Background Color
        filled: true,
        fillColor: Colors.blue[50],
        
        // 4. Borders (The most important part for styling)
        
        // Default border (when not focused)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        
        // Border when clicked (focused)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(19, 164, 236, 1),
            width: 2.0,
          ),
        ),
        
        // Border when there is an error (optional)
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //     width: 1.5,
        //   ),
        // ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String fontFamily;
  
  const PasswordTextField({super.key, required this.fontFamily});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isObscured,
      decoration: InputDecoration(
        // 1. Labels and Hints
        labelText: 'Password',
        //hintText: 'Enter your unique username',
        //helperText: 'Must be at least 6 characters',

        //Styles
        labelStyle: TextStyle(height: 3.5, fontFamily: widget.fontFamily),
        
        // 2. Icons
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
            // Logic: If obscured, show "eye". If visible, show "crossed eye".
            icon: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              // 4. Toggle the state when pressed
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
        //suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
        
        // 3. Background Color
        filled: true,
        fillColor: Colors.blue[50],
        
        // 4. Borders (The most important part for styling)
        
        // Default border (when not focused)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        
        // Border when clicked (focused)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(19, 164, 236, 1),
            width: 2.0,
          ),
        ),
        
        // Border when there is an error (optional)
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //     width: 1.5,
        //   ),
        // ),
      ),
    );
  }
}

class ConfirmPasswordTextField extends StatefulWidget {
  final String fontFamily;
  
  const ConfirmPasswordTextField({super.key, required this.fontFamily});

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isObscured,
      decoration: InputDecoration(
        // 1. Labels and Hints
        labelText: 'Confirm Password',
        //hintText: 'Enter your unique username',
        //helperText: 'Must be at least 6 characters',

        //Styles
        labelStyle: TextStyle(height: 3.5, fontFamily: widget.fontFamily),
        
        // 2. Icons
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
            // Logic: If obscured, show "eye". If visible, show "crossed eye".
            icon: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              // 4. Toggle the state when pressed
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
        //suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
        
        // 3. Background Color
        filled: true,
        fillColor: Colors.blue[50],
        
        // 4. Borders (The most important part for styling)
        
        // Default border (when not focused)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        
        // Border when clicked (focused)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(19, 164, 236, 1),
            width: 2.0,
          ),
        ),
        
        // Border when there is an error (optional)
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //     width: 1.5,
        //   ),
        // ),
      ),
    );
  }
}

class BottomSignUpButton extends StatelessWidget {
  final FontWeight weight700;
  final String fontFamily;
  final Color bgColor;
  const BottomSignUpButton({super.key, required this.weight700, required this.fontFamily, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Drugscanner(bgColor: bgColor)));},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(19, 164, 236, 1),
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Text("Sign Up", style: TextStyle(fontWeight: weight700, fontFamily: fontFamily, height: 3.5, color: Colors.white),),
      );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  final String fontFamily;
  final Color bgColor;
  const AlreadyHaveAccount({super.key, required this.fontFamily, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text("Already have an account?", style: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 1.25, color: Color.fromRGBO(75, 85, 99, 1)),),
        TextButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(bgColor: bgColor, fontFamily: fontFamily, weight700: FontWeight.w700)));
          },
          child: Text("Sign In", style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, color: Color.fromRGBO(19, 164, 236, 1)),)
        )
      ],
    );
  }
}