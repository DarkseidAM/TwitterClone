import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<GetUserDataUseCase> getUserDataUseCaseProvider =
    Provider<GetUserDataUseCase>((ProviderRef<GetUserDataUseCase> ref) {
  return GetUserDataUseCase(
      tweetRepository: ref.watch(tweetRepositoryProvider));
});

class GetUserDataUseCase implements UseCase<String, UserModel> {
  const GetUserDataUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  final TweetRepository _tweetRepository;

  @override
  Future<UserModel> invoke(String params) {
    return _tweetRepository.getUserData(params);
  }
}
