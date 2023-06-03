import 'package:appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/home/data/repository/home_repository_impl.dart';
import 'package:twitter_clone/features/home/domain/repository/home_repository.dart';

final Provider<CurrentUserAccountUseCase> currentUserAccountUseCaseProvider =
    Provider<CurrentUserAccountUseCase>(
        (ProviderRef<CurrentUserAccountUseCase> ref) {
  return CurrentUserAccountUseCase(
      homeRepository: ref.watch(homeRepositoryProvider));
});

class CurrentUserAccountUseCase implements UseCase<NoParams, User?> {
  const CurrentUserAccountUseCase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  Future<User?> invoke(NoParams params) {
    return _homeRepository.currentUserAccount();
  }
}
