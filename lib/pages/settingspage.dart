import 'package:clear_pill_project/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  final Color bgColor;
  final Color color;
  final FontWeight weight700;
  final String fontFamily;
  const SettingsPage({super.key, required this.color, required this.weight700, required this.fontFamily, required this.bgColor});

  void _logout(BuildContext context) async {
    // 1. Get the instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 2. Clear the specific key (or use prefs.clear() to remove everything)
    await prefs.setBool('isLoggedIn', false);

    // 3. Navigate back to Login and remove history
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login(bgColor: bgColor)),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Settings", style: TextStyle(fontWeight: weight700, fontSize: 20, height: 1.75, fontFamily: fontFamily),),
        centerTitle: true,
      ),

      body: SettingsBody(color: color, weight700: weight700, fontFamily: fontFamily, logout: () {_logout(context);},),
    );
  }
}

class SettingsBody extends StatelessWidget {
  final Color color;
  final FontWeight weight700;
  final String fontFamily;
  final VoidCallback logout;
  const SettingsBody({super.key, required this.color, required this.weight700, required this.fontFamily, required this.logout});

  @override
  Widget build(BuildContext context) {
    final Color labelColor = Color.fromRGBO(0, 0, 0, 0.5);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 1, bottom: 32),
      child: ListView(
        children: <Widget> [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          
              //Padding
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 1, bottom: 8, top: 8),
                child: Text("ACCOUNT", style: TextStyle(color: labelColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 14),),
              ),

              //Acount
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.person_2_outlined, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Account Details", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Manage your account details", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
                onTap: logout,
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 80,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.lock_outline_sharp, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Change Password", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Change your password", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 20,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              
              //Preferences
              SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 1, bottom: 8, top: 8),
                child: Text("PREFERENCES", style: TextStyle(color: labelColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 14),),
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.wb_sunny_outlined, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Appearance", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Customize app appearance", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 80,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.notifications_active_outlined, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Notifications", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Manage notification settings", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 80,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.language_outlined, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Language", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Set your preferred language", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 20,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
            
              //Support
              SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 1, bottom: 8, top: 8),
                child: Text("SUPPORT", style: TextStyle(color: labelColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 14),),
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.help_center_outlined, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Help Center", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Get help and support", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 80,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.mail_outline, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("Contact Us", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Contact us for assistance", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 80,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
              ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(19, 164, 236, 0.2),
                    child: Icon(Icons.info_outline, color: Color.fromRGBO(19, 164, 236, 1),),
                  ),
                ),
                title: Text("About", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w600),),
                subtitle: Text("Learn more about the app", style: TextStyle(fontFamily: fontFamily, color: Color.fromRGBO(0, 0, 0, 0.6), fontSize: 14, height: 1.25),),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Color.fromRGBO(0, 0, 0, 0.3),),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.1), // Color of the line
                thickness: 1,        // Thickness of the line
                indent: 20,          // Empty space at the start
                endIndent: 20,       // Empty space at the end
              ),
            
            ],
          ),
        ]
      ),
    );
  }
}