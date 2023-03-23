import 'package:appwrite/models.dart' as model;
import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';

part 'authenticated_root_guard.g.dart';

@riverpod
AuthenticatedRootGuard authenticatedRootGuard(AuthenticatedRootGuardRef ref) =>
    AuthenticatedRootGuard(ref.read(currentUserAccountUseCaseProvider));

class AuthenticatedRootGuard extends AutoRouteGuard {
  AuthenticatedRootGuard(this._currentUserAccountUseCase);
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
