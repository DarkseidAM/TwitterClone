import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/core/theme/palette.dart';

class AppTheme {
  AppTheme._();
  static ThemeData theme = ThemeData.dark().copyWith(
    useMaterial3: false,
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
