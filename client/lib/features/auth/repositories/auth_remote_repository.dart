import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:http/http.dart' as http;
import 'package:music_app/core/constants/server_constants.dart';
import 'package:music_app/core/failure/app_failure.dart';
import 'package:music_app/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Call the API to register
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/signup'),

        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      // Left({"detail":"User already exist"})
      if (response.statusCode != 201) {
        print('Failed to register user');
        return Left(AppFailure(resBodyMap['detail']));
      }
      print(resBodyMap);
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      print(e);
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    // Call the API to login
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/login'),

        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print(response.body);
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print('Failed to login user');
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(
        UserModel.fromMap(
          resBodyMap['user'],
        ).copyWith(token: resBodyMap['token']),
      );
    } catch (e) {
      print(e);
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    // Call the API to login
    try {
      final response = await http.get(
        Uri.parse('${ServerConstants.serverURL}/auth/'),

        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      print(response.body);
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap).copyWith(token: token));
    } catch (e) {
      print(e);
      return Left(AppFailure(e.toString()));
    }
  }
}
