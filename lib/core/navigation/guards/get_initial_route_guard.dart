import 'package:appwrite/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';

final Provider<GetInitialRoute> getInitialRouteProvider =
    Provider<GetInitialRoute>((ProviderRef<GetInitialRoute> ref) {
  return GetInitialRoute(ref.watch(currentUserAccountUseCaseProvider));
});

class GetInitialRoute extends AutoRouteGuard {
  GetInitialRoute(
    this._currentUserAccountUseCase,
  );
  final CurrentUserAccountUseCase _currentUserAccountUseCase;

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    try {
      final User? account = await _currentUserAccountUseCase.invoke(NoParams());
      FlutterNativeSplash.remove();
      if (account == null) {
        resolver.next();
      } else {
        router.push(const HomeRoute());
      }
    } catch (e) {
      router.push(ErrorRoute(error: e.toString()));
    }
  }
}
