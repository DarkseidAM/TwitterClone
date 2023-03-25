import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) => email.split('@')[0];

bool ifUrl(String word) =>
    word.startsWith('https://') ||
    word.startsWith('http://') ||
    word.startsWith('www.');

Future<List<File>> pickImages() async {
  final List<File> images = List<File>.empty(growable: true);
  final ImagePicker imagePicker = ImagePicker();
  final List<XFile> imageFiles = await imagePicker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final XFile image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}
