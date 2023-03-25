import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';

final Provider<TweetDataSource> tweetDataSourceProvider =
    Provider<TweetDataSource>((ProviderRef<TweetDataSource> ref) {
  return TweetDataSourceImpl(
    databases: ref.watch(databasesProvider),
    storage: ref.watch(storageProvider),
  );
});

abstract class TweetDataSource {
  Future<model.Document> getUserData(String uid);
  Future<model.Document> shareTweet(Tweet tweet);
  Future<List<String>> uploadImage(List<File> images);
  Future<List<model.Document>> getTweets();
}

class TweetDataSourceImpl implements TweetDataSource {
  const TweetDataSourceImpl({
    required Databases databases,
    required Storage storage,
  })  : _databases = databases,
        _storage = storage;

  final Databases _databases;
  final Storage _storage;

  @override
  Future<model.Document> getUserData(String uid) {
    return _databases.getDocument(
      databaseId: AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.usersCollection,
      documentId: uid,
    );
  }

  @override
  Future<model.Document> shareTweet(Tweet tweet) {
    try {
      return _databases.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollection,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  @override
  Future<List<String>> uploadImage(List<File> files) async {
    try {
      final List<String> imageLinks = List<String>.empty(growable: true);
      for (final File file in files) {
        final model.File uploadedImage = await _storage.createFile(
          bucketId: AppWriteConstants.imagesBucket,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: file.path),
        );
        imageLinks.add(AppWriteConstants.imageUrl(uploadedImage.$id));
      }
      return imageLinks;
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  @override
  Future<List<model.Document>> getTweets() async {
    try {
      final model.DocumentList documents = await _databases.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollection,
      );
      return documents.documents;
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }
}
