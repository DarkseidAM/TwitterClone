import 'dart:io';

import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';

abstract class TweetRepository {
  Future<UserModel> getUserData(String uid);
  FutureEither<model.Document> shareTweet(Tweet tweet);
  Future<List<String>> uploadImage(List<File> files);
  Future<List<model.Document>> getTweets();
}
