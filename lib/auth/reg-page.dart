import 'package:clear_pill_project/auth/auth-service.dart';
import 'package:clear_pill_project/auth/login-page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Color bgColor;
  final String fontFamily;
  final FontWeight weight700;
  const RegisterPage({super.key, required this.bgColor, required this.fontFamily, required this.weight700});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _submit() async {
    String userName = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if(userName == "") {
      _showMessage("Enter your UserName");
      return;
    } else if(password == "") {
      _showMessage("Enter your password");
      return;
    } else if(password != confirmPassword) {
      _showMessage("Passwords do not match");
      return;
    } else if(password.length < 8) {
      _showMessage("Password length should be greater than 8");
      return;
    }

    String result = await _authService.register(userName, password);

    if(result == "Success") {
      _showMessage("Registered Successfully! Please Login.");
      setState(() {
        // Switch to login screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(bgColor: widget.bgColor, fontFamily: widget.fontFamily, weight700: widget.weight700)));
      });
    } else {
      _showMessage("Register Failed: $result");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        title: Text("Register", style: TextStyle(fontWeight: widget.weight700, fontFamily: widget.fontFamily, fontSize: 18, height: 1.75),),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(24),
        child: LoginCredentials(fontFamily: widget.fontFamily, weight700: widget.weight700, bgColor: widget.bgColor, usernameController: _usernameController, passwordController: _passwordController, confirmPasswordController: _confirmPasswordController, submit: () {_submit();},),
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
  final TextEditingController confirmPasswordController;
  final VoidCallback submit;
  const LoginCredentials({super.key, required this.fontFamily, required this.weight700, required this.bgColor, required this.usernameController, required this.passwordController, required this.confirmPasswordController, required this.submit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Spacer(),
        CreateYourAccountText(fontFamily: fontFamily, weight700: weight700),
        SizedBox(height: 40,),
        UserNameTextField(fontFamily: fontFamily, usernameController: usernameController,),
        SizedBox(height: 24,),
        PasswordTextField(fontFamily: fontFamily, passwordController: passwordController,),
        SizedBox(height: 24,),
        ConfirmPasswordTextField(fontFamily: fontFamily, confirmPasswordController: confirmPasswordController,),
        SizedBox(height: 24,),
        BottomSignUpButton(weight700: weight700, fontFamily: fontFamily, bgColor: bgColor, submit: () {submit();},),
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

class ConfirmPasswordTextField extends StatefulWidget {
  final String fontFamily;
  final TextEditingController confirmPasswordController;
  const ConfirmPasswordTextField({super.key, required this.fontFamily, required this.confirmPasswordController});

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.confirmPasswordController,
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
  final VoidCallback submit;
  const BottomSignUpButton({super.key, required this.weight700, required this.fontFamily, required this.bgColor, required this.submit});

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