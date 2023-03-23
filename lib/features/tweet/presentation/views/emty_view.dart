import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmptyRoute extends StatelessWidget {
  const EmptyRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
