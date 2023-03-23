import 'package:twitter_clone/features/tweet/data/models/user_model.dart';

abstract class TweetRepository {
  Future<UserModel> getUserData(String uid);
}
