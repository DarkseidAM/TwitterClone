import 'package:auto_route/annotations.dart';
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart';
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart';
import 'package:twitter_clone/features/home/presentation/views/home_view.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  preferRelativeImports: false,
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SignUpView,
      initial: true,
    ),
    AutoRoute(
      page: LoginView,
      path: '/login',
    ),
    AutoRoute(
      page: HomeView,
      path: '/home',
    )
  ],
)
class AppRouter extends _$AppRouter {}
