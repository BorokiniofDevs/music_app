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
  return '#${(color.r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
          '${(color.g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
          '${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}'
      .toUpperCase();
}

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", ""); // Remove # if present

  if (hex.length == 6) {
    hex = "FF$hex"; // Add full opacity if missing
  }

  Color color = Color(int.parse(hex, radix: 16));

  // ✅ Print debug info
  print(
    'Converted hex: #$hex → Color(r: ${color.r}, g: ${color.g}, b: ${color.b}, a: ${color.a})',
  );

  return color;
}
