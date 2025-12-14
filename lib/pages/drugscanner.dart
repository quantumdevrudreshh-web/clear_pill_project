import 'dart:io';

import 'package:clear_pill_project/pages/MedicationHomepage.dart';
import 'package:clear_pill_project/pages/MedicationSchedule.dart';
import 'package:clear_pill_project/pages/drugdetails.dart';
import 'package:clear_pill_project/pages/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Drugscanner extends StatefulWidget {
  final Color bgColor;
  const Drugscanner({super.key, required this.bgColor});

  @override
  State<Drugscanner> createState() => _DrugscannerState();
}

class _DrugscannerState extends State<Drugscanner> {
  // 1. Track the current index
  int _currentIndex = 0;
  Color color = Color.fromRGBO(16, 28, 34, 1);
  FontWeight weight700 = FontWeight.w700;
  String fontFamily = "Manrope";

  // 2. Define the pages for each tab
  List<Widget> get _pages => [
    DrugScannerBody(color: color, weight700: weight700, fontFamily: fontFamily, bgColor: widget.bgColor,),
    const Center(child: Text('History Page', style: TextStyle(fontSize: 24))),
    Medicationschedule(color: color, weight700: weight700, fontFamily: "ManropeBold", bgColor: widget.bgColor,),
    MedicationHomepage(fontFamily: fontFamily, weight700: weight700, bgColor: widget.bgColor)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: widget.bgColor,
      // appBar: AppBar(
      //   backgroundColor: widget.bgColor,
      //   leading: Icon(null),
      //   title: Text("Drug Scanner", style: TextStyle(color: color, fontFamily: fontFamily, fontWeight: weight700, fontSize: 20),),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(color: color, weight700: weight700, fontFamily: fontFamily, bgColor: widget.bgColor)));},
      //       icon: Icon(Icons.settings, size: 24, color: Color.fromRGBO(19, 164, 236, 1),)
      //     )
      //   ],
      // ),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        // Important for more than 3 items:
        type: BottomNavigationBarType.fixed, 

        backgroundColor: widget.bgColor,
        
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        
        // Styling
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        
        // The Items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite), // Changes icon when selected
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DrugScannerBody extends StatefulWidget {
  final Color color;
  final FontWeight weight700;
  final String fontFamily;
  final Color bgColor;
  const DrugScannerBody({super.key, required this.color, required this.weight700, required this.fontFamily, required this.bgColor});

  @override
  State<DrugScannerBody> createState() => _DrugScannerBodyState();
}

class _DrugScannerBodyState extends State<DrugScannerBody> {

  // Variable to store the captured image
  File? _selectedImage;

  // The ImagePicker instance
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      print("Error opening camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      backgroundColor: widget.bgColor,
      appBar: AppBar(
        backgroundColor: widget.bgColor,
        leading: Icon(null),
        title: Text("Drug Scanner", style: TextStyle(color: widget.color, fontFamily: widget.fontFamily, fontWeight: widget.weight700, fontSize: 20),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(color: widget.color, weight700: widget.weight700, fontFamily: widget.fontFamily, bgColor: widget.bgColor)));},
            icon: Icon(Icons.settings, size: 24, color: Color.fromRGBO(19, 164, 236, 1),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontFamily: widget.fontFamily, color: Color.fromRGBO(16, 28, 34, 0.5), fontSize: 20, height: 1),
                      // Add a search icon to the left
                      prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(16, 28, 34, 0.5), size: 24,),
                      // Add a clear button to the right
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _controller.clear(),
                      ),
                      // Background styling
                      filled: true,
                      fillColor: const Color.fromRGBO(16, 28, 34, 0.05),
                      // Remove the default underline and add rounded corners
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none, 
                      ),
                      // Optional: Add a shadow effect using a Container wrapper usually, 
                      // but enabledBorder works for simple outlines.
                    ),
                    onChanged: (value) {
                      // Perform search logic here
                    },
                  ),
                ),
            
                Text(
                  "Quick Scan",
                  style: TextStyle(fontSize: 24, fontFamily: widget.fontFamily, height: 1.5, fontWeight: widget.weight700),
                  textAlign: TextAlign.left,
                ),
            
                SizedBox(height: 16,),
            
                GestureDetector(
                  onTap: () {
                    _openCamera();
                  },
                  // ClipRRect cuts the child into a rounded shape
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBa0Aq-wjkKlubf2fe8FZmlbWSf4EpDmF-pzpK3VC30wlioDsvzsuQtPBwrxUK-HeYrYg5JPRWMNeyVWToa30Z5ZEBc9YA3liWLTi9CFgfcAGNYTVruBxdFFwiK1uzV3wnHsV-s9TkKgcG4yHYfDPFW0uQ6anopheLCOHCAryAZFB7t-QIOxyv2bM9TR7jmITzqz7NIzRB1NXlD2-8sVvlLkqASJsXACyqbO-R1ZObyoLe-8wgweriDtZgbX1qdtgrYODfmJVmCkCQ',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              
                SizedBox(height: 16,),
            
                Text(
                  "Explore",
                  style: TextStyle(fontSize: 24, fontFamily: widget.fontFamily, height: 1.5, fontWeight: widget.weight700),
                  textAlign: TextAlign.left,
                ),
            
                SizedBox(height: 16,),
              
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(8.0),
            
                    children: <Widget>[
                      _buildImageCard('https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&q=80', 'Common Medications', DrugDetails(bgColor: Color.fromRGBO(246, 247, 248, 1))),
                      _buildImageCard('https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=400&q=80', 'Common Medications', DrugDetails(bgColor: Color.fromRGBO(246, 247, 248, 1))),
                      _buildImageCard('https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=400&q=80', 'Common Medications', DrugDetails(bgColor: Color.fromRGBO(246, 247, 248, 1))),
                      _buildImageCard('https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400&q=80', 'Common Medications', DrugDetails(bgColor: Color.fromRGBO(246, 247, 248, 1))),
                      _buildImageCard('https://images.unsplash.com/photo-1501854140884-074bf6b243e7?w=400&q=80', 'Common Medications', DrugDetails(bgColor: Color.fromRGBO(246, 247, 248, 1))),
                    ],
                  ),
                )
                
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildImageCard(String url, String , Widget widgetPage) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => widgetPage));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0), // Space between images
        width: 250, // Fixed width for each item
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}