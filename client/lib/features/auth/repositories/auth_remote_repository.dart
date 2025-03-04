import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Call the API to register
    final response = await http.post(
      Uri.parse('http://192.168.46.154:8000/auth/signup'),

      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    print(response.body);
    print(response.statusCode);
  }

  Future<void> login({required String email, required String password}) async {
    // Call the API to login
    final response = await http.post(
      Uri.parse('http://192.168.46.154:8000/auth/login'),

      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.body);
    print(response.statusCode);
  }
}
