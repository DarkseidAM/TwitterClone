import 'package:flutter/material.dart';
import 'package:twitter_clone/core/theme/theme.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textObscured = false,
  });
  final TextEditingController controller;
  final String hintText;
  final bool textObscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: textObscured,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
