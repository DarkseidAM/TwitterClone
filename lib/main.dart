import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:twitter_clone/core/navigation/app_router.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/custom_proxy.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';
import 'package:twitter_clone/features/home/presentation/controller/home_controller.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kDebugMode) {
    final CustomProxy httpProxy = CustomProxy(
      ipAddress: '10.252.115.199',
      port: 8888,
      allowBadCertificates: true,
    );
    httpProxy.enable();
  }
  runApp(
    const ProviderScope(
      child: RouterWidget(),
    ),
  );
}

class RouterWidget extends ConsumerStatefulWidget {
  const RouterWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RouterWidgetState();
}

class _RouterWidgetState extends ConsumerState<RouterWidget> {
  AppRouter? _appRouter;

  @override
  void initState() {
    super.initState();
    initializeAppRouter();
  }

  Future<void> initializeAppRouter() async {
    _appRouter = AppRouter(
      getInitialRoute: GetInitialRoute(
        currentUserAccountProvider: ref.read(currentUserAccountProvider),
      ),
      authenticatedRootGuard: AuthenticatedRootGuard(
        currentUserAccountUseCase: ref.read(currentUserAccountUseCaseProvider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyApp(_appRouter);
  }
}

class MyApp extends ConsumerWidget {
  const MyApp(AppRouter? appRouter, {super.key}) : _appRouter = appRouter;

  final AppRouter? _appRouter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerDelegate: _appRouter?.delegate(
        navigatorObservers: () => <NavigatorObserver>[
          MyObserver(
            logger: ref.read(loggerProvider),
          ),
        ],
      ),
      routeInformationParser: _appRouter?.defaultRouteParser(),
    );
  }
}

class MyObserver extends AutoRouterObserver {
  MyObserver({
    required Logger logger,
  }) : _logger = logger;
  final Logger _logger;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.d('New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _logger.d('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.d('Tab route re-visited: ${route.name}');
  }
}
