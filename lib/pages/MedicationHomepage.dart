import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Task {
  final String title;
  final String instructionTitle;
  final TimeOfDay time;
  bool isDone;

  Task({required this.title, required this.time, this.isDone = false, required this.instructionTitle});
}

class MedicationHomepage extends StatefulWidget {
  final String fontFamily;
  final FontWeight weight700;
  final Color bgColor;
  const MedicationHomepage({super.key, required this.fontFamily, required this.weight700, required this.bgColor});

  @override
  State<MedicationHomepage> createState() => _MedicationHomepageState();
}

class _MedicationHomepageState extends State<MedicationHomepage> {
  Color headingColor = Color.fromRGBO(13, 23, 27, 1);
  Color bgColorAfterOnTap = Color.fromRGBO(74, 144, 226, 0.2);
  Color buttonFontColor = Color.fromRGBO(74, 144, 226, 1);
  Color subContentColor = Color.fromRGBO(142, 142, 147, 1);

  // 1. Define your Tasks
  // Using a simple Map structure: {'title': String, 'isDone': bool}
  final List<Task> _tasks = [
    Task(title: "Lunch", time: const TimeOfDay(hour: 13, minute: 0), instructionTitle: 'Take After Food', isDone: false), // 1:00 PM
    Task(title: "Project Work", time: const TimeOfDay(hour: 14, minute: 30), instructionTitle: 'Take Before Food', isDone: false), // 2:30 PM
    Task(title: "Gym", time: const TimeOfDay(hour: 17, minute: 0), instructionTitle: 'Any time', isDone: false), // 5:00 PM
    Task(title: "Walk Dog", time: const TimeOfDay(hour: 18, minute: 30), instructionTitle: 'With Food', isDone: false), // 6:30 PM
    Task(title: "Dinner", time: const TimeOfDay(hour: 20, minute: 0), instructionTitle: 'Take After Food', isDone: false), // 8:00 PM
    Task(title: "Read Book", time: const TimeOfDay(hour: 22, minute: 0), instructionTitle: 'Take Before Food', isDone: false), // 10:00 PM
    Task(title: "Team Meeting", time: const TimeOfDay(hour: 10, minute: 0), instructionTitle: 'Take Before Food', isDone: false),
    Task(title: "Wake Up", time: const TimeOfDay(hour: 6, minute: 30), instructionTitle: 'Take Before Food', isDone: false),
  ];

  // 2. Helper to calculate progress (0.0 to 1.0)
  int get _progress {
    if (_tasks.isEmpty) return 0;
    int completedCount = _tasks.where((t) => t.isDone == true).length;
    return completedCount;
  }
  
  @override
  Widget build(BuildContext context) {

    // Calculate percentage string (e.g., "40%")
    String completed = "${(_progress).toInt()}";

    String indicator = "$completed of ${_tasks.length} doses taken";

    return Scaffold(
      backgroundColor: widget.bgColor,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        title: Text("My Schedule", style: TextStyle(fontFamily: widget.fontFamily, fontWeight: widget.weight700, height: 1.25, color: headingColor, fontSize: 20),),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 14),
        actions: <Widget> [
          Icon(Icons.notifications_outlined, size: 28, color: headingColor,)
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: <Widget> [
            HorizontalDateScroller(bgColorAfterOnTap: bgColorAfterOnTap, fontFamily: widget.fontFamily, subColor: headingColor, buttonFontColor: buttonFontColor,),
            SizedBox(height: 16,),
            // --- THE PROGRESS BAR SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: headingColor, height: 1.5, fontFamily: widget.fontFamily),
                ),
                Text(
                  indicator,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: subContentColor,
                      fontFamily: widget.fontFamily,
                      height: 1.5
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // The Progress Bar Widget
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              child: LinearProgressIndicator(
                value: _progress / 5, // Current value (0.0 to 1.0)
                minHeight: 10, // Thickness
                backgroundColor: Colors.grey[300], // Background color
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent), // Fill color
                // Optional: Add animation value color if needed
              ),
            ),

            const SizedBox(height: 16),
            CategorizedTasksPage(headingColor: headingColor, buttonFontColor: buttonFontColor, subContentColor: subContentColor, fontFamily: widget.fontFamily, allTasks: _tasks,)
          ],
        ),
      ),
    );
  }
}

class HorizontalDateScroller extends StatefulWidget {
  final Color bgColorAfterOnTap;
  final String fontFamily;
  final Color subColor;
  final Color buttonFontColor;

  const HorizontalDateScroller({super.key, required this.bgColorAfterOnTap, required this.fontFamily, required this.subColor, required this.buttonFontColor});

  @override
  State<HorizontalDateScroller> createState() => _HorizontalDateScrollerState();
}

class _HorizontalDateScrollerState extends State<HorizontalDateScroller> {
  late List<DateTime> nextSevenDays;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Generate the next 7 days starting from today
    final now = DateTime.now();
    nextSevenDays = List.generate(7, (index) => now.add(Duration(days: index)));

    // Automatically select today initially
    selectedDate = nextSevenDays.first;
  }

  // Helper to compare dates without worrying about time/hours/minutes
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    // Important: Horizontal ListViews need a constrained height constraint
    return SizedBox(
      height: 64, // Adjust height based on your design preference
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nextSevenDays.length,
        // Bouncing physics feels better on iOS, Clamping on Android generally
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final date = nextSevenDays[index];
          final isSelected = isSameDay(date, selectedDate!);

          return Padding(
            // Add spacing between cards
            padding: EdgeInsets.only(
                left: index == 0 ? 0 : 12.0, // No padding on the very first item
            ),
            child: _DateButtonCard(
              date: date,
              isSelected: isSelected,
              bgColorAfterOnTap: widget.bgColorAfterOnTap,
              fontFamily: widget.fontFamily,
              subColor: widget.subColor,
              buttonFontColor: widget.buttonFontColor,
              onTap: () {
                setState(() {
                  selectedDate = date;
                });
                print("Selected date: ${DateFormat('yyyy-MM-dd').format(date)}");
              }, 
            ),
          );
        },
      ),
    );
  }
}

// --- Custom Widget for the individual card ---
class _DateButtonCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;
  final Color bgColorAfterOnTap;
  final String fontFamily;
  final Color subColor;
  final Color buttonFontColor;


  const _DateButtonCard({
    required this.date,
    required this.isSelected,
    required this.onTap, required this.bgColorAfterOnTap, required this.fontFamily, required this.subColor, required this.buttonFontColor,
  });

  @override
  Widget build(BuildContext context) {
    // Formatters: 'E' gives short day (Mon), 'd' gives date number (14)
    final dayName = DateFormat('E').format(date);
    final dateNumber = DateFormat('d').format(date);

    // Define colors based on selection state
    final backgroundColor = isSelected ? bgColorAfterOnTap : Colors.white;
    final textColor = isSelected ? buttonFontColor : Colors.black87;
    final borderColor = isSelected ? Colors.teal : Colors.grey.shade300;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 64, // Fixed width for uniform cards
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: borderColor, width: 1.5),
            // boxShadow: isSelected
            //     ? [
            //   BoxShadow(
            //       color: Colors.teal.withOpacity(0.3),
            //       blurRadius: 8,
            //       offset: const Offset(0, 4))
            // ]
            //     : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Day Name (e.g., Mon)
              Text(
                dayName.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(height: 4),
              // Date Number (e.g., 14)
              Text(
                dateNumber,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  height: 1.75,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontFamily
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorizedTasksPage extends StatefulWidget {
  final Color headingColor;
  final Color buttonFontColor;
  final Color subContentColor;
  final String fontFamily;
  final List<Task> allTasks;
  
  const CategorizedTasksPage({super.key, required this.headingColor, required this.buttonFontColor, required this.subContentColor, required this.fontFamily, required this.allTasks});

  @override
  State<CategorizedTasksPage> createState() => _CategorizedTasksPageState();
}

class _CategorizedTasksPageState extends State<CategorizedTasksPage> {

  // 3. Helper to determine category
  String _getCategory(TimeOfDay time) {
    // Convert to total minutes for easy comparison
    // hour * 60 + minute
    int totalMinutes = time.hour * 60 + time.minute;

    // Ranges (in minutes):
    // 6:00 AM (360) to 11:59 AM (719)
    if (totalMinutes >= 360 && totalMinutes <= 719) {
      return "Morning Intake";
    }
    // 12:00 PM (720) to 3:59 PM (959)
    else if (totalMinutes >= 720 && totalMinutes <= 959) {
      return "Afternoon Intake";
    }
    // 4:00 PM (960) to 6:50 PM (1130)
    else if (totalMinutes >= 960 && totalMinutes <= 1130) {
      return "Evening Intake";
    }
    // 7:00 PM (1140) to 11:00 PM (1380)
    else if (totalMinutes >= 1140 && totalMinutes <= 1380) {
      return "Late Night Intake";
    } 
    else {
      return "Other / Early Morning";
    }
  }

  // 4. Group the tasks into a Map
  Map<String, List<Task>> get _groupedTasks {
    Map<String, List<Task>> groups = {
      "Morning Intake": [],
      "Afternoon Intake": [],
      "Evening Intake": [],
      "Late Night Intake": [],
      "Other / Early Morning": []
    };

    for (var task in widget.allTasks) {
      String category = _getCategory(task.time);
      print(category);
      // Only add if the category exists in our map (filters out super early/late stuff if needed)
      if (groups.containsKey(category)) {
        groups[category]!.add(task);
      } else {
        // Handle "Other" if necessary
        groups.putIfAbsent(category, () => []).add(task);
      }
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {

    // Sort the list in place
    widget.allTasks.sort((a, b) {
      // Convert time to "minutes from midnight"
      int minutesA = a.time.hour * 60 + a.time.minute;
      int minutesB = b.time.hour * 60 + b.time.minute;
      
      // Compare them (Ascending order: 6 AM -> 10 PM)
      return minutesA.compareTo(minutesB);
    });

    final groupedTasks = _groupedTasks;
    // Get keys that actually have tasks, to avoid showing empty headers
    final activeCategories = groupedTasks.keys
        .where((key) => groupedTasks[key]!.isNotEmpty)
        .toList();

    return Expanded(
      child: ListView.builder(
          itemCount: activeCategories.length,
          itemBuilder: (context, index) {
            String category = activeCategories[index];
            List<Task> tasksInSection = groupedTasks[category]!;
      
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- SECTION HEADER ---
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: widget.fontFamily,
                    color: widget.headingColor
                  ),
                ),
      
                // --- TASKS IN THIS SECTION ---
                ...tasksInSection.map((task) {
                  bool isTaken = task.isDone;
                  return ListTile(
                    leading: Text(
                      task.time.format(context), // Displays 6:30 AM
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, fontFamily: widget.fontFamily),
                    ),
                    title: Text(task.title, style: TextStyle(fontFamily: widget.fontFamily, color: widget.headingColor, fontWeight: FontWeight.w500),),
                    subtitle: Text(task.instructionTitle, style: TextStyle(fontFamily: widget.fontFamily, color: widget.subContentColor, fontWeight: FontWeight.w500, height: 1.5),),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          task.isDone = !task.isDone; // Toggle logic                        
                        });
                        // Call API to update status here if needed
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          // Change Color based on status
                          color: isTaken ? null : Color.fromRGBO(74, 144, 226, 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isTaken ? Icons.check_circle : Icons.medication_outlined,
                              color: isTaken ? Colors.green : widget.buttonFontColor,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isTaken ? "TAKEN" : "TAKE",
                              style: TextStyle(
                                color: isTaken ? Colors.green : widget.buttonFontColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: widget.fontFamily,
                                height: 1.25
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
    );
  }
}
