import 'package:appwrite/models.dart' as model;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';
import 'package:twitter_clone/core/widgets/error_page.dart';
import 'package:twitter_clone/core/widgets/loading_page.dart';
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart';
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart';
import 'package:twitter_clone/features/home/presentation/views/home_view.dart';

@MaterialAutoRouter(
  preferRelativeImports: false,
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SignUpView,
      path: RouterConstants.signUpRoute,
    ),
    AutoRoute(
      page: LoginView,
      path: RouterConstants.loginRoute,
      initial: true,
      guards: <Type>[
        GetInitialRoute,
      ],
    ),
    AutoRoute(
      page: HomeView,
      path: RouterConstants.homeRoute,
    ),
    AutoRoute(
      page: LoadingPage,
      path: RouterConstants.loading,
    ),
    AutoRoute(
      page: ErrorPage,
      path: RouterConstants.error,
    ),
  ],
)
class $AppRouter {}

class GetInitialRoute extends AutoRouteGuard {
  GetInitialRoute({
    required AsyncValue<Future<model.Account?>> currentUserAccountProvider,
  }) : _currentUserAccountProvider = currentUserAccountProvider;
  final AsyncValue<Future<model.Account?>> _currentUserAccountProvider;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _currentUserAccountProvider.when(
      data: (Future<model.Account?> futureUser) async {
        final model.Account? user = await futureUser;
        if (user == null) {
          resolver.next();
        } else {
          router.pushNamed(RouterConstants.homeRoute);
        }
      },
      error: (Object error, StackTrace stacktrace) {
        router.pushNamed(RouterConstants.error);
      },
      loading: () {
        router.pushNamed(RouterConstants.loading);
      },
    );
  }
}
