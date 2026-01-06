import 'dart:convert';
import 'package:http/http.dart' as http;

// Data Model
class Reminder {
  final int? id;
  final String reminderTime;
  final String foodInstruction;

  Reminder({this.id, required this.reminderTime, required this.foodInstruction});

  // Convert JSON from Server to Dart Object
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      reminderTime: json['reminderTime'],
      foodInstruction: json['foodInstruction'],
    );
  }
}

// API Helper
class ReminderService {
  // Use 10.0.2.2 for Emulator, localhost for iOS, or your PC IP for Real Device
  final String baseUrl = "http://192.168.0.107:8080/api/reminders"; 

  Future<List<Reminder>> getReminders(String? userId) async {

    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Reminder.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load reminders");
    }
  }

  Future<void> addReminder(String? userId, String time, String instruction) async {
    print(userId);
    print("----------------------------");
    await http.post(
      Uri.parse('$baseUrl/add/user/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "reminderTime": time,
        "foodInstruction": instruction,
      }),
    );
  }
  
  Future<void> deleteReminder(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}