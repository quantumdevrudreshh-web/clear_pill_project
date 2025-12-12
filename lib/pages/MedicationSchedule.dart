import 'dart:ffi';

import 'package:clear_pill_project/pages/ReminderTime.dart';
import 'package:clear_pill_project/reminder/reminder-service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medicationschedule extends StatefulWidget {
  final Color color;
  final FontWeight weight700;
  final String fontFamily;
  final Color bgColor;
  const Medicationschedule({super.key, required this.color, required this.weight700, required this.fontFamily, required this.bgColor});

  @override
  State<Medicationschedule> createState() => _MedicationscheduleState();
}

class _MedicationscheduleState extends State<Medicationschedule> {

  Color subHeadColor = Color.fromRGBO(51, 51, 51, 1);
  Color headColor = Color.fromRGBO(51, 51, 51, 0.8);

  dynamic _selectedValue;

  final List<String> _items = ["mg", "mcg", "g", "ml", "pill(s)"];

  List<DropdownMenuItem<dynamic>> get _dropdownItems {
    return _items.map((String items) {
      return DropdownMenuItem<dynamic>(
        value: items,
        child: Text(items, style: TextStyle(color: subHeadColor, height: 1.5, fontWeight: FontWeight.w400, fontSize: 16),),
      );
    }).toList();
  }

  // ***BACKEND SPRINGBOOT ***
  final ReminderService _api = ReminderService();
  List<Reminder> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Load data from DB when app starts
  }

  // Fetch data from Spring Boot
  void _fetchData() async {
    try {
      // Getting UserId from Login Page i.e Shared Preferences.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      var data = await _api.getReminders(userId);
      setState(() {
        _reminders = data;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        title: Text("Add New Medication", style: TextStyle(color: subHeadColor, fontFamily: widget.fontFamily, letterSpacing: -0.4, height: 1.25, fontWeight: widget.weight700, fontSize: 18),),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Medication Details", style: TextStyle(color: headColor, fontWeight: FontWeight.w600, fontSize: 16, height: 1.5, fontFamily: widget.fontFamily),),
            SizedBox(height: 16,),
            Text("Medication Name", style: TextStyle(color: subHeadColor, fontWeight: FontWeight.w500, fontSize: 14, height: 1.25, fontFamily: widget.fontFamily),),
            SizedBox(height: 8,),
            TextField(
              //controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                // 1. Labels and Hints
                hintText: 'e.g., Ibuprofen',
                //Styles
                hintStyle: TextStyle(height: 1.5, fontFamily: widget.fontFamily, fontWeight: FontWeight.w400, fontSize: 16, color: subHeadColor),
                                
                // 3. Background Color
                filled: true,
                fillColor: Colors.white,
                
                // 4. Borders (The most important part for styling)
                
                // Default border (when not focused)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                ),
                
                // Border when clicked (focused)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(59, 130, 246, 0.5),
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
            ),
            SizedBox(height: 16,),
            Text("Dosage", style: TextStyle(color: subHeadColor, fontWeight: FontWeight.w500, fontSize: 14, height: 1.25, fontFamily: widget.fontFamily),),
            SizedBox(height: 16,),

            Row(
              spacing: 14,
              children: <Widget> [
                Expanded(
                  flex: 3,
                  child: TextField(
                    //controller: usernameContrfoller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      // 1. Labels and Hints
                      hintText: 'e.g., 200',
                      //Styles
                      hintStyle: TextStyle(height: 1.5, fontFamily: widget.fontFamily, fontWeight: FontWeight.w400, fontSize: 16, color: subHeadColor),
                                      
                      // 3. Background Color
                      filled: true,
                      fillColor: Colors.white,
                      
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
                          color: Color.fromRGBO(59, 130, 246, 0.5),
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
                  ),
                ),
                        
                Expanded(
                  flex: 1,
                  child: Container(
                    //width: 96,      
                    height: 50,      
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color.fromRGBO(59, 130, 246, 0.5), width: 2),
                    ),
                    child: DropdownButton<dynamic>(
                      icon: Icon(Icons.expand_circle_down),
                      iconSize: 18,
                      value: _selectedValue,
                      hint: Text("Unit"),
                      items: _dropdownItems,
                      onChanged: (dynamic newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 24,),

            Text("Schedule & Reminders", style: TextStyle(color: headColor, fontSize: 16, height: 1.5, fontWeight: FontWeight.w600, fontFamily: widget.fontFamily),),
            SizedBox(height: 16,),
            Text("What time(s) should we remind you?", style: TextStyle(fontFamily: widget.fontFamily, color: subHeadColor, fontSize: 14, height: 1.25, fontWeight: FontWeight.w500),),
            SizedBox(height: 12,),
            Expanded(
              child: Stack (
                children: <Widget> [
                  _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _reminders.isEmpty
                      ? const Center(child: Text("No reminders found in DB"))
                      : ListView.builder(
                          itemCount: _reminders.length,
                          itemBuilder: (context, index) {
                            final item = _reminders[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text("${index + 1}", style: TextStyle(fontFamily: widget.fontFamily),),
                                ),
                                title: Text(item.reminderTime,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontFamily: widget.fontFamily)),
                                subtitle: Text(item.foodInstruction, style: TextStyle(fontFamily: widget.fontFamily),),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    // Delete from DB
                                    await _api.deleteReminder(item.id!);
                                    _fetchData(); // Refresh list
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),

            // To add the Alarm function.
            DottedBorder(
              color: Color.fromRGBO(74, 144, 226, 0.4), // Color of the dots
              strokeWidth: 2, // Thickness of the dots
              dashPattern: const [6, 3], // 6px Line, 3px Space
              borderType: BorderType.RRect, // Rounded Rectangle
              radius: const Radius.circular(12), // Corner Radius
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderTime(fontFamily: widget.fontFamily, weight700: widget.weight700, bgColor: widget.bgColor)));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(74, 144, 226, 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, fontWeight: FontWeight.normal, size: 24, color: Color.fromRGBO(74, 144, 226, 1),),
                      Text(
                        'Add Reminder Time',
                        style: TextStyle(fontSize: 14, height: 1.25, color: Color.fromRGBO(74, 144, 226, 1), fontFamily: widget.fontFamily, fontWeight: FontWeight.w600,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}