import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart';
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart';
import 'package:twitter_clone/features/home/presentation/views/home_view.dart';

class NavigationRouter {
  NavigationRouter._();
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RouterConstants.signUpRoute,
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpView(),
        routes: <RouteBase>[
          GoRoute(
            path: RouterConstants.loginRoute,
            builder: (BuildContext context, GoRouterState state) =>
                const LoginView(),
          ),
          GoRoute(
            path: RouterConstants.homeRoute,
            builder: (BuildContext context, GoRouterState state) =>
                const HomeView(),
          ),
        ],
      )
    ],
  );
}
