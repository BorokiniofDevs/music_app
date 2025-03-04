import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<String, Map<String, dynamic>>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Call the API to register
    try {
      final response = await http.post(
        Uri.parse('http://192.168.46.154:8000/auth/signup'),

        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      if (response.statusCode != 201) {
        print('Failed to register user');
        return Left(response.body);
      }
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      print(user);
      return Right(user);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    // Call the API to login
    try {
      final response = await http.post(
        Uri.parse('http://192.168.46.154:8000/auth/login'),

        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
