import 'package:appwrite/models.dart' as model;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/core/utils/common_utils.dart';
import 'package:twitter_clone/core/widgets/common_widgets.dart';
import 'package:twitter_clone/features/auth/presentation/views/login_view.dart';
import 'package:twitter_clone/features/auth/presentation/views/signup_view.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';
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
      initial: true,
      path: RouterConstants.loginRoute,
      guards: <Type>[
        GetInitialRoute,
      ],
    ),
    AutoRoute(
      page: HomeView,
      path: RouterConstants.homeRoute,
      guards: <Type>[
        AuthenticatedRootGuard,
      ],
    ),
    AutoRoute(
      page: LoadingView,
      path: RouterConstants.loading,
    ),
    AutoRoute(
      page: ErrorView,
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
        router.push(ErrorRoute(error: error.toString()));
      },
      loading: () {
        router.pushNamed(RouterConstants.loading);
      },
    );
  }
}

class AuthenticatedRootGuard extends AutoRouteGuard {
  AuthenticatedRootGuard({
    required CurrentUserAccountUseCase currentUserAccountUseCase,
  }) : _currentUserAccountUseCase = currentUserAccountUseCase;
  final CurrentUserAccountUseCase _currentUserAccountUseCase;

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    try {
      final model.Account? account =
          await _currentUserAccountUseCase.invoke(NoParams());
      if (firstLogin) {
        resolver.next();
      } else if (account != null) {
        resolver.next();
      } else {
        router.pushNamed(RouterConstants.loginRoute);
      }
    } catch (e) {
      router.push(ErrorRoute(error: e.toString()));
    }
  }
}
