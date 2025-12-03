import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  // Use 10.0.2.2 for Android Emulator, localhost for iOS
  final String baseUrl = "http://10.0.2.2:8080/api/auth";

  //RegisterFunction
  Future<String> register(String userName, String password) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(url, headers: {"Content-Type" : "application/json"}, body: jsonEncode({"userName" : userName, "password" : password}));

      if(response.statusCode == 200) {
        return "Success";
      } else {
        return response.body;
      }
    } catch (e) {
      return "Error : $e";
    }
  }

  // Login Function
  Future<Map<String, dynamic>> login(String userName, String password) async {
    final url = Uri.parse('$baseUrl/login');
    
    try {
      final response = await http.post(url, headers: {"Content-Type" : "application/json"}, body: jsonEncode({"userName" : userName, "password" : password}));

      if(response.statusCode == 200) {
        return {"success" : true, "data" : jsonDecode(response.body)};
      } else {
        return {"success" : false, "message" : response.body};
      }
    } catch (e) {
      return {"success" : false, "message" : "Connection Error"};
    }
  }

}