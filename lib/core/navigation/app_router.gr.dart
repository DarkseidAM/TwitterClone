// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:twitter_clone/core/widgets/error_view.dart' as _i1;
import 'package:twitter_clone/core/widgets/loading_view.dart' as _i2;
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart'
    as _i3;
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart'
    as _i4;
import 'package:twitter_clone/features/home/presentation/views/home_view.dart'
    as _i5;
import 'package:twitter_clone/features/tweet/presentation/views/create_tweet_view.dart'
    as _i6;
import 'package:twitter_clone/features/tweet/presentation/views/emty_view.dart'
    as _i7;
import 'package:twitter_clone/features/tweet/presentation/views/tweet_list.dart'
    as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    ErrorTextRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorTextRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ErrorText(
          key: args.key,
          error: args.error,
        ),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ErrorView(
          key: args.key,
          error: args.error,
        ),
      );
    },
    Loader.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Loader(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoadingView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
    CreateTweetRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CreateTweetView(),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EmptyRoute(),
      );
    },
    TweetListRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.TweetList(),
      );
    },
  };
}

/// generated route for
/// [_i1.ErrorText]
class ErrorTextRoute extends _i9.PageRouteInfo<ErrorTextRouteArgs> {
  ErrorTextRoute({
    _i10.Key? key,
    required String error,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          ErrorTextRoute.name,
          args: ErrorTextRouteArgs(
            key: key,
            error: error,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorTextRoute';

  static const _i9.PageInfo<ErrorTextRouteArgs> page =
      _i9.PageInfo<ErrorTextRouteArgs>(name);
}

class ErrorTextRouteArgs {
  const ErrorTextRouteArgs({
    this.key,
    required this.error,
  });

  final _i10.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorTextRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i1.ErrorView]
class ErrorRoute extends _i9.PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    _i10.Key? key,
    required String error,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          ErrorRoute.name,
          args: ErrorRouteArgs(
            key: key,
            error: error,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static const _i9.PageInfo<ErrorRouteArgs> page =
      _i9.PageInfo<ErrorRouteArgs>(name);
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.key,
    required this.error,
  });

  final _i10.Key? key;

  final String error;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [_i2.Loader]
class Loader extends _i9.PageRouteInfo<void> {
  const Loader({List<_i9.PageRouteInfo>? children})
      : super(
          Loader.name,
          initialChildren: children,
        );

  static const String name = 'Loader';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoadingView]
class LoadingRoute extends _i9.PageRouteInfo<void> {
  const LoadingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignUpView]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CreateTweetView]
class CreateTweetRoute extends _i9.PageRouteInfo<void> {
  const CreateTweetRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CreateTweetRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateTweetRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EmptyRoute]
class EmptyRoute extends _i9.PageRouteInfo<void> {
  const EmptyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.TweetList]
class TweetListRoute extends _i9.PageRouteInfo<void> {
  const TweetListRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TweetListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TweetListRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
