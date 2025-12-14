import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 112),
        child: Column(
          children: <Widget> [
            HorizontalDateScroller(bgColorAfterOnTap: bgColorAfterOnTap, fontFamily: widget.fontFamily, subColor: headingColor, buttonFontColor: buttonFontColor,)
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