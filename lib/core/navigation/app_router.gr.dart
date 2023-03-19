// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:twitter_clone/core/navigation/app_router.dart' as _i8;
import 'package:twitter_clone/core/widgets/error_page.dart' as _i5;
import 'package:twitter_clone/core/widgets/loading_page.dart' as _i4;
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart'
    as _i2;
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart'
    as _i1;
import 'package:twitter_clone/features/home/presentation/views/home_view.dart'
    as _i3;

class AppRouter extends _i6.RootStackRouter {
  AppRouter({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.getInitialRoute,
  }) : super(navigatorKey);

  final _i8.GetInitialRoute getInitialRoute;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SignUpRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignUpView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LoadingPage.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoadingPage(),
      );
    },
    ErrorPage.name: (routeData) {
      final args = routeData.argsAs<ErrorPageArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ErrorPage(
          key: args.key,
          error: args.error,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SignUpRoute.name,
          path: '/signUp',
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/',
          guards: [getInitialRoute],
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i6.RouteConfig(
          LoadingPage.name,
          path: '/loading',
        ),
        _i6.RouteConfig(
          ErrorPage.name,
          path: 'error',
        ),
      ];
}

/// generated route for
/// [_i1.SignUpView]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/signUp',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoadingPage]
class LoadingPage extends _i6.PageRouteInfo<void> {
  const LoadingPage()
      : super(
          LoadingPage.name,
          path: '/loading',
        );

  static const String name = 'LoadingPage';
}

/// generated route for
/// [_i5.ErrorPage]
class ErrorPage extends _i6.PageRouteInfo<ErrorPageArgs> {
  ErrorPage({
    _i7.Key? key,
    required String error,
  }) : super(
          ErrorPage.name,
          path: 'error',
          args: ErrorPageArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'ErrorPage';
}

class ErrorPageArgs {
  const ErrorPageArgs({
    this.key,
    required this.error,
  });

  final _i7.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorPageArgs{key: $key, error: $error}';
  }
}
