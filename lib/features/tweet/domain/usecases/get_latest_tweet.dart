import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<GetLatestTweetUseCase> getLatestTweetUseCaseProvider =
    Provider<GetLatestTweetUseCase>((ProviderRef<GetLatestTweetUseCase> ref) {
  return GetLatestTweetUseCase(
      tweetRepository: ref.watch(tweetRepositoryProvider));
});

class GetLatestTweetUseCase
    implements StreamUseCase<NoParams, RealtimeMessage> {
  const GetLatestTweetUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  final TweetRepository _tweetRepository;

  @override
  Stream<RealtimeMessage> invoke(NoParams params) {
    return _tweetRepository.getLatestTweet();
  }
}
