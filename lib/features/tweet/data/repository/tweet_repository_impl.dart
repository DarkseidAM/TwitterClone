import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/features/tweet/data/data_souce/tweet_data_source.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
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

  @override
  FutureEither<model.Document> shareTweet(Tweet tweet) async {
    try {
      final model.Document response = await _tweetDataSource.shareTweet(tweet);
      return right(response);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? e.toString(), stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<List<String>> uploadImage(List<File> files) {
    return _tweetDataSource.uploadImage(files);
  }

  @override
  Future<List<model.Document>> getTweets() {
    return _tweetDataSource.getTweets();
  }
}
