import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:music_app/core/constants/server_constants.dart';

class HomeRepository {
  Future<void> uploadSong(File selectedImage, File selectedAudio) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ServerConstants.serverURL}/song/upload'),
    );
    // Add your implementation here
    request
      ..files.addAll([
        await http.MultipartFile.fromPath('song', selectedAudio.path),
        await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
      ])
      ..fields.addAll({
        'artist': 'Taylor Swift',
        'song_name': 'Love Story',
        'hex_code': 'FFFFFF',
      })
      ..headers.addAll({
        'x-auth-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA1N2U0OTFlLTYzMmEtNDc1NC1iZjQ1LWE5N2ZlYThiMDdhNSJ9.kb76V5IEe2svAE6gMGeh4lOkF1iaPmoBN-mkjQc_ATI',
      });

    final res = await request.send();
    print(res);
  }
}
