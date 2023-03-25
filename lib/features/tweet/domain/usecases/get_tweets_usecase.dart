import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<GetTweetsUseCase> getTweetsUseCaseProvider =
    Provider<GetTweetsUseCase>((ProviderRef<GetTweetsUseCase> ref) {
  return GetTweetsUseCase(tweetRepository: ref.watch(tweetRepositoryProvider));
});

class GetTweetsUseCase implements UseCase<NoParams, List<model.Document>> {
  const GetTweetsUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  final TweetRepository _tweetRepository;

  @override
  Future<List<model.Document>> invoke(NoParams params) {
    return _tweetRepository.getTweets();
  }
}
