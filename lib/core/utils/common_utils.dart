import 'package:flutter/material.dart';

bool firstLogin = false;

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
