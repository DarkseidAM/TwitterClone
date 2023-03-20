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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:twitter_clone/core/navigation/app_router.dart' as _i7;
import 'package:twitter_clone/core/widgets/common_widgets.dart' as _i4;
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart'
    as _i2;
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart'
    as _i1;
import 'package:twitter_clone/features/home/presentation/views/home_view.dart'
    as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter({
    _i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
    required this.getInitialRoute,
    required this.authenticatedRootGuard,
  }) : super(navigatorKey);

  final _i7.GetInitialRoute getInitialRoute;

  final _i7.AuthenticatedRootGuard authenticatedRootGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SignUpRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignUpView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoadingView(),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ErrorView(
          key: args.key,
          error: args.error,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i5.RouteConfig(
          SignUpRoute.name,
          path: '/signUp',
        ),
        _i5.RouteConfig(
          LoginRoute.name,
          path: '/login',
          guards: [getInitialRoute],
        ),
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/home',
          guards: [authenticatedRootGuard],
        ),
        _i5.RouteConfig(
          LoadingRoute.name,
          path: '/loading',
        ),
        _i5.RouteConfig(
          ErrorRoute.name,
          path: '/error',
        ),
      ];
}

/// generated route for
/// [_i1.SignUpView]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/signUp',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoadingView]
class LoadingRoute extends _i5.PageRouteInfo<void> {
  const LoadingRoute()
      : super(
          LoadingRoute.name,
          path: '/loading',
        );

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i4.ErrorView]
class ErrorRoute extends _i5.PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    _i6.Key? key,
    required String error,
  }) : super(
          ErrorRoute.name,
          path: '/error',
          args: ErrorRouteArgs(
            key: key,
            error: error,
          ),
        );

  static const String name = 'ErrorRoute';
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    required this.error,
  });

  final _i6.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, error: $error}';
  }
}
