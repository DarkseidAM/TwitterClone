import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart';
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart';

class NavigationRouter {
  NavigationRouter._();
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SingUpView(),
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginView(),
          )
        ],
      )
    ],
  );
}
