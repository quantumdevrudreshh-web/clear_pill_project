import 'dart:ffi';

import 'package:clear_pill_project/pages/MedicationSchedule.dart';
import 'package:clear_pill_project/reminder/reminder-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderTime extends StatefulWidget {
  final String fontFamily;
  final FontWeight weight700;
  final Color bgColor;
  const ReminderTime({super.key, required this.fontFamily, required this.weight700, required this.bgColor});

  @override
  State<ReminderTime> createState() => _ReminderTimeState();
}

class _ReminderTimeState extends State<ReminderTime> {
  Color darkColor = Color.fromRGBO(28, 28, 30, 1);
  Color lightColor = Color.fromRGBO(108, 108, 112, 1);

  // From Reminder Service.
  final ReminderService _api = ReminderService();

  // Text controller and Store the selected time
  TextEditingController instructionCtrl = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // 1. The list of options
  final List<String> _options = [
    "Any",
    "Before Food",
    "With Food",
    "After Food",
  ];

  // 2. Variable to track the selected index (-1 means nothing selected)
  int _selectedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        title: Text("Set Reminder Time", style: TextStyle(color: darkColor, fontFamily: widget.fontFamily, letterSpacing: -0.4, height: 1.25, fontWeight: widget.weight700, fontSize: 18),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                  "${_formatNumber(_selectedTime.hour > 12 ? _selectedTime.hour - 12 : _selectedTime.hour == 0 ? 12 : _selectedTime.hour)}:${_formatNumber(_selectedTime.minute)} ${_selectedTime.hour >= 12 ? 'PM' : 'AM'}",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontFamily: widget.fontFamily
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Selected Time",
                  style: TextStyle(color: Colors.redAccent, fontFamily: widget.fontFamily),
                ),
            
                const SizedBox(height: 50),
            
                // 2. The Scrolling Picker Container
                // CupertinoDatePicker MUST be wrapped in a container with a fixed height.
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
            
                  // 3. The Actual Scrolling Widget
                  child: CupertinoDatePicker(
                    // Sets it to Time mode (Hour | Minute | AM/PM)
                    mode: CupertinoDatePickerMode.time,
                    
                    // Crucial: Set this to false to get the AM/PM column
                    use24hFormat: false, 
                    
                    // Default starting time
                    initialDateTime: DateTime.now(),
                    
                    // Callback when user scrolls
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        _selectedTime = TimeOfDay.fromDateTime(newTime);
                      });
                    },
                  ),
                ),
            
                const SizedBox(height: 50),
              ],
            ),
        
            Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text("FOOD INSTRUCTIONS", style: TextStyle(color: Color.fromRGBO(108, 108, 112, 1), letterSpacing: 0.8, fontWeight: FontWeight.w500, fontFamily: widget.fontFamily, fontSize: 14, height: 1.25),),
        
                const SizedBox(height: 20),
        
                // 3. Generate the list of options dynamically
                ...List.generate(_options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15), // Spacing between items
                    child: InkWell(
                      onTap: () {
                        // 4. Update state on click
                        setState(() {
                          _selectedIndex = index;
                          instructionCtrl.text = _options[_selectedIndex];
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          // 5. Change Color based on Selection
                          color: _selectedIndex == index 
                              ? Colors.blue[50] 
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedIndex == index 
                                ? Colors.blue 
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _options[index],
                              style: TextStyle(
                                fontFamily: widget.fontFamily,
                                fontSize: 16,
                                fontWeight: _selectedIndex == index 
                                    ? FontWeight.bold 
                                    : FontWeight.normal,
                                color: _selectedIndex == index 
                                    ? Colors.blue 
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                
                const SizedBox(height: 20),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: _selectedIndex == -1 
                //         ? null // Disable button if nothing selected
                //         : () {
                //             print("User selected: ${_options[_selectedIndex]}");
                //           },
                //     child: const Text("Submit Answer"),
                //   ),
                // )
              ],
            ),
            // 4. Save Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(74, 144, 226, 1),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: () async {
                  if(_selectedIndex == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Choose Food Instructions')),
                    );
                  } else {
                    // Getting UserId from Login Page i.e Shared Preferences.
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? userId = prefs.getString('userId'); // Returns "15"
                    String timeStr = _selectedTime.format(context);

                    await _api.addReminder(userId, timeStr, instructionCtrl.text);
                    Navigator.of(context)
                      ..pop()
                      ..pop()
                      ..push(MaterialPageRoute(builder: (context) => Medicationschedule(color: Color.fromRGBO(16, 28, 34, 1), weight700: widget.weight700, fontFamily: widget.fontFamily, bgColor: widget.bgColor)));
                  }
                },
                child: Text(
                  "Save Time",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: widget.weight700, fontFamily: widget.fontFamily, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  DateTime convertToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }
}