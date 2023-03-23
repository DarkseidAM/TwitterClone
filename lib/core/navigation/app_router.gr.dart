// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:twitter_clone/core/widgets/error_view.dart' as _i1;
import 'package:twitter_clone/core/widgets/loading_view.dart' as _i2;
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart'
    as _i4;
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart'
    as _i5;
import 'package:twitter_clone/features/home/presentation/views/home_view.dart'
    as _i3;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ErrorText.name: (routeData) {
      final args = routeData.argsAs<ErrorTextArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ErrorText(
          key: args.key,
          error: args.error,
        ),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ErrorView(
          key: args.key,
          error: args.error,
        ),
      );
    },
    Loader.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Loader(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoadingView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignUpView(),
      );
    },
  };
}

/// generated route for
/// [_i1.ErrorText]
class ErrorText extends _i6.PageRouteInfo<ErrorTextArgs> {
  ErrorText({
    _i7.Key? key,
    required String error,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ErrorText.name,
          args: ErrorTextArgs(
            key: key,
            error: error,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorText';

  static const _i6.PageInfo<ErrorTextArgs> page =
      _i6.PageInfo<ErrorTextArgs>(name);
}

class ErrorTextArgs {
  const ErrorTextArgs({
    this.key,
    required this.error,
  });

  final _i7.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorTextArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i1.ErrorView]
class ErrorRoute extends _i6.PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    _i7.Key? key,
    required String error,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ErrorRoute.name,
          args: ErrorRouteArgs(
            key: key,
            error: error,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static const _i6.PageInfo<ErrorRouteArgs> page =
      _i6.PageInfo<ErrorRouteArgs>(name);
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    required this.error,
  });

  final _i7.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i2.Loader]
class Loader extends _i6.PageRouteInfo<void> {
  const Loader({List<_i6.PageRouteInfo>? children})
      : super(
          Loader.name,
          initialChildren: children,
        );

  static const String name = 'Loader';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoadingView]
class LoadingRoute extends _i6.PageRouteInfo<void> {
  const LoadingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginView]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SignUpView]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
