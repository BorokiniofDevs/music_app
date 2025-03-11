import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/core/constants/server_constants.dart';
import 'package:music_app/core/failure/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstants.serverURL}/song/upload'),
      );
      // Add your implementation here
      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath(
            'thumbnail',
            selectedThumbnail.path,
          ),
        ])
        ..fields.addAll({
          'artist': artist,
          'song_name': songName,
          'hex_code': hexCode,
        })
        ..headers.addAll({'x-auth-token': token});

      final res = await request.send();
      print(res);

      if (res.statusCode != 201) {
        return Left(AppFailure(await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
