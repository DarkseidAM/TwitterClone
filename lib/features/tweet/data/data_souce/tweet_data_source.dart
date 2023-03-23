import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/utils/constants.dart';

final Provider<TweetDataSource> tweetDataSourceProvider =
    Provider<TweetDataSource>((ProviderRef<TweetDataSource> ref) {
  return TweetDataSourceImpl(databases: ref.watch(databasesProvider));
});

abstract class TweetDataSource {
  Future<model.Document> getUserData(String uid);
}

class TweetDataSourceImpl implements TweetDataSource {
  const TweetDataSourceImpl({required Databases databases})
      : _databases = databases;

  final Databases _databases;

  @override
  Future<model.Document> getUserData(String uid) {
    return _databases.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: uid,
    );
  }
}
