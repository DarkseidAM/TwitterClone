import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/features/tweet/data/data_souce/tweet_data_source.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<TweetRepository> tweetRepositoryProvider =
    Provider<TweetRepository>((ProviderRef<TweetRepository> ref) {
  return TweetRepositoryImpl(
      tweetDataSource: ref.watch(tweetDataSourceProvider));
});

class TweetRepositoryImpl implements TweetRepository {
  const TweetRepositoryImpl({required TweetDataSource tweetDataSource})
      : _tweetDataSource = tweetDataSource;

  final TweetDataSource _tweetDataSource;

  @override
  Future<UserModel> getUserData(String uid) async {
    final model.Document document = await _tweetDataSource.getUserData(uid);
    return UserModel.fromMap(document.data);
  }
}
