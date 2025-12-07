import 'package:clear_pill_project/auth/auth-service.dart';
import 'package:clear_pill_project/pages/drugscanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Color bgColor;
  final String fontFamily;
  final FontWeight weight700;
  const LoginPage({super.key, required this.bgColor, required this.fontFamily, required this.weight700});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _submit() async {
    String userName = _usernameController.text;
    String password = _passwordController.text;

    print(_usernameController);

    var result = await _authService.login(userName, password);

    if(result['success']) {
      // 1. Get the instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // 2. Save the value!
      await prefs.setBool('isLoggedIn', true); 
      // You can also save the User ID or Token here:
      // await prefs.setString('userId', '12345');

      // 3. Navigate to Home
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Drugscanner(bgColor: widget.bgColor)),
          (route) => false,
        );
      }
    } else {
      _showMessage("Login Failed: ${result['message']}");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(fontWeight: widget.weight700, fontFamily: widget.fontFamily, fontSize: 18, height: 1.75),),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(24),
        child: LoginCredentials(fontFamily: widget.fontFamily, weight700: widget.weight700, bgColor: widget.bgColor, usernameController: _usernameController, passwordController: _passwordController, submit: () { _submit(); },),
      ),
    );
  }
}

class LoginCredentials extends StatelessWidget {
  final String fontFamily;
  final FontWeight weight700;
  final Color bgColor;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback submit;
  const LoginCredentials({super.key, required this.fontFamily, required this.weight700, required this.bgColor, required this.usernameController, required this.passwordController, required this.submit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Spacer(),
        UserNameTextField(fontFamily: fontFamily, usernameController: usernameController,),
        SizedBox(height: 24,),
        PasswordTextField(fontFamily: fontFamily, passwordController: passwordController,),
        SizedBox(height: 24,),
        ForgotPassword(fontFamily: fontFamily),
        Spacer(),
        BottomLoginButton(weight700: weight700, fontFamily: fontFamily, bgColor: bgColor, submit: () { submit(); },)
      ],
    );
  }
}

class UserNameTextField extends StatelessWidget {
  final String fontFamily;
  final TextEditingController usernameController;
  const UserNameTextField({super.key, required this.fontFamily, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
        // 1. Labels and Hints
        labelText: 'Username',
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
  final TextEditingController passwordController;
  const PasswordTextField({super.key, required this.fontFamily, required this.passwordController});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
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

class BottomLoginButton extends StatelessWidget {
  final FontWeight weight700;
  final String fontFamily;
  final Color bgColor;
  final VoidCallback submit;
  const BottomLoginButton({super.key, required this.weight700, required this.fontFamily, required this.bgColor, required this.submit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {submit();},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(19, 164, 236, 1),
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Text("Login", style: TextStyle(fontWeight: weight700, fontFamily: fontFamily, height: 3.5, color: Colors.white),),
      );
  }
}

class ForgotPassword extends StatelessWidget {
  final String fontFamily;
  const ForgotPassword({super.key, required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text("Forgot Password?", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(19, 164, 236, 1), fontWeight: FontWeight.w600, fontSize: 14, height: 1.25),);
  }
}