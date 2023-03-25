import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/navigation/guards/authenticated_root_guard.dart';
import 'package:twitter_clone/core/navigation/guards/get_initial_route_guard.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((ProviderRef<AppRouter> ref) {
  return AppRouter(
    ref.watch(getInitialRouteProvider),
    ref.watch(authenticatedRootGuardProvider),
  );
});

@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends $AppRouter {
  AppRouter(this._getInitialRoute, this._authenticatedRootGuard);

  final GetInitialRoute _getInitialRoute;
  final AuthenticatedRootGuard _authenticatedRootGuard;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = <AutoRoute>[
    AutoRoute(
      page: SignUpRoute.page,
      path: RouterConstants.signUpRoute,
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: RouterConstants.loginRoute,
      guards: <AutoRouteGuard>[
        _getInitialRoute,
      ],
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: RouterConstants.homeRoute,
      guards: <AutoRouteGuard>[
        _authenticatedRootGuard,
      ],
      children: <AutoRoute>[
        AutoRoute(
          page: TweetListRoute.page,
          path: RouterConstants.tweetList,
        ),
        AutoRoute(
          page: EmptyRoute.page,
          path: 'empty',
        ),
      ],
    ),
    AutoRoute(
      page: CreateTweetRoute.page,
      path: RouterConstants.tweet,
      fullscreenDialog: true,
    ),
    AutoRoute(
      page: LoadingRoute.page,
      path: RouterConstants.loading,
    ),
    AutoRoute(
      page: ErrorRoute.page,
      path: RouterConstants.error,
    ),
  ];
}
