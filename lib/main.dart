import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:twitter_clone/core/navigation/app_router.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/custom_proxy.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kDebugMode) {
    final CustomProxy httpProxy = CustomProxy(
      ipAddress: '192.168.0.211',
      port: 8888,
      allowBadCertificates: true,
    );
    httpProxy.enable();
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Twitter Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: ref.read(appRouterProvider).config(
            navigatorObservers: () => <NavigatorObserver>[
              MyObserver(
                logger: ref.read(loggerProvider),
              ),
            ],
          ),
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

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _logger.d('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.d('Tab route re-visited: ${route.name}');
  }
}
