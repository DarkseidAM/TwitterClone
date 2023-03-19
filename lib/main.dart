import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/navigation/app_router.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/features/home/presentation/controller/home_controller.dart';

void main() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      routerDelegate: _appRouter?.delegate(),
      routeInformationParser: _appRouter?.defaultRouteParser(),
    );
  }
}
