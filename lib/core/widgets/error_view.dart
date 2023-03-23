import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.error,
  });
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}

@RoutePage()
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
  });
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(error: error),
    );
  }
}
