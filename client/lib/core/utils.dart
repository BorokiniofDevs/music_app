import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallete.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(content), backgroundColor: Pallete.gradient3),
    );
}
