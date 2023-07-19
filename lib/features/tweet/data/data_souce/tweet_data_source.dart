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
      realtime: ref.watch(realtimeProvider));
});

abstract class TweetDataSource {
  Future<model.Document> getUserData(String uid);
  Future<model.Document> shareTweet(Tweet tweet);
  Future<List<String>> uploadImage(List<File> images);
  Future<List<model.Document>> getTweets();
  Stream<RealtimeMessage> getLatestTweet();
  Future<model.Document> likeTweet(Tweet tweet);
  Future<model.Document> updateReshareCount(Tweet tweet);
}

class TweetDataSourceImpl implements TweetDataSource {
  const TweetDataSourceImpl({
    required Databases databases,
    required Storage storage,
    required Realtime realtime,
  })  : _databases = databases,
        _storage = storage,
        _realtime = realtime;

  final Databases _databases;
  final Storage _storage;
  final Realtime _realtime;

  @override
  Future<model.Document> getUserData(String uid) {
    try {
      return _databases.getDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: uid,
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
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
        queries: <String>[
          Query.orderDesc('tweetedAt'),
        ],
      );
      return documents.documents;
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  @override
  Stream<RealtimeMessage> getLatestTweet() {
    try {
      return _realtime.subscribe(<String>[
        'databases.${AppWriteConstants.databaseId}.collections.${AppWriteConstants.tweetsCollection}.documents'
      ]).stream;
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  @override
  Future<model.Document> likeTweet(Tweet tweet) {
    try {
      return _databases.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollection,
        documentId: tweet.id,
        data: <String, List<String>>{
          'likes': tweet.likes,
        },
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }
  
  @override
  Future<model.Document> updateReshareCount(Tweet tweet) {
    try {
      return _databases.updateDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetsCollection,
        documentId: tweet.id,
        data: <String, int>{
          'reshareCount': tweet.reshareCount,
        },
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }
}
