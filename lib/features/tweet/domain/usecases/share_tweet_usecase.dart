import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<ShareTweetUseCase> shareTweetUseCaseProvider =
    Provider<ShareTweetUseCase>((ProviderRef<ShareTweetUseCase> ref) {
  return ShareTweetUseCase(tweetRepository: ref.watch(tweetRepositoryProvider));
});

class ShareTweetUseCase implements EitherUseCase<Tweet, model.Document> {
  const ShareTweetUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;
  final TweetRepository _tweetRepository;

  @override
  FutureEither<model.Document> invoke(Tweet params) {
    return _tweetRepository.shareTweet(params);
  }
}
