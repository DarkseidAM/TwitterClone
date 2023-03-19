import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';

final AutoDisposeStateNotifierProvider<HomeController, bool>
    homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, bool>(
        (StateNotifierProviderRef<HomeController, bool> ref) {
  return HomeController(
    currentUserAccountUseCase: ref.read(currentUserAccountUseCaseProvider),
  );
});

final AutoDisposeFutureProvider<Future<model.Account?>>
    currentUserAccountProvider = FutureProvider.autoDispose(
        (AutoDisposeFutureProviderRef<Future<model.Account?>> ref) {
  final HomeController homeController =
      ref.watch(homeControllerProvider.notifier);
  return homeController.currentUser();
});

class HomeController extends StateNotifier<bool> {
  HomeController({
    required CurrentUserAccountUseCase currentUserAccountUseCase,
  })  : _currentUserAccountUseCase = currentUserAccountUseCase,
        super(false);
  final CurrentUserAccountUseCase _currentUserAccountUseCase;

  Future<model.Account?> currentUser() =>
      _currentUserAccountUseCase.invoke(NoParams());
}