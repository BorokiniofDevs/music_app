import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallete.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(content), backgroundColor: Pallete.gradient3),
    );
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.path!);
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.path!);
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

String rgbToHex(Color color) {
  return '${color.r.round().toRadixString(16).padLeft(2, '0')}${color.g.round().toRadixString(16).padLeft(2, '0')}${color.b.round().toRadixString(16).padLeft(2, '0')})';
}

Color hexToColor(String hexCode) {
  return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
}
