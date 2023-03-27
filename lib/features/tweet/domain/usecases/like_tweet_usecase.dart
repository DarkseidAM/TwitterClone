import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<LikeTweetUseCase> likeTweetUseCaseProvider =
    Provider<LikeTweetUseCase>((ProviderRef<LikeTweetUseCase> ref) {
  return LikeTweetUseCase(tweetRepository: ref.watch(tweetRepositoryProvider));
});

class LikeTweetUseCase implements EitherUseCase<Tweet, model.Document> {
  const LikeTweetUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  final TweetRepository _tweetRepository;

  @override
  FutureEither<model.Document> invoke(Tweet params) {
    return _tweetRepository.likeTweet(params);
  }
}
