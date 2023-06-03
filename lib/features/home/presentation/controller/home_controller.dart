import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/home/domain/usecases/current_user_account_usecase.dart';

final StateNotifierProvider<HomeController, bool> homeControllerProvider =
    StateNotifierProvider<HomeController, bool>(
        (StateNotifierProviderRef<HomeController, bool> ref) {
  return HomeController(
    currentUserAccountUseCase: ref.watch(currentUserAccountUseCaseProvider),
  );
});

final FutureProvider<User?> currentUserAccountProvider =
    FutureProvider<User?>((FutureProviderRef<User?> ref) {
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

  Future<User?> currentUser() => _currentUserAccountUseCase.invoke(NoParams());
}
