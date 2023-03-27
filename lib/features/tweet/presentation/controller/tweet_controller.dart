import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/core/utils/common_utils.dart';
import 'package:twitter_clone/features/home/presentation/controller/home_controller.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/get_latest_tweet.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/get_tweets_usecase.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/get_user_data_usecase.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/like_tweet_usecase.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/share_tweet_usecase.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/upload_image_usecase.dart';

final StateNotifierProvider<TweetController, bool> tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>(
        (StateNotifierProviderRef<TweetController, bool> ref) {
  return TweetController(
    getUserDataUseCase: ref.watch(getUserDataUseCaseProvider),
    shareTweetUseCase: ref.watch(shareTweetUseCaseProvider),
    uploadImageUseCase: ref.watch(uploadImageUseCaseProvider),
    getTweetsUseCase: ref.watch(getTweetsUseCaseProvider),
    likeTweetUseCase: ref.watch(likeTweetUseCaseProvider),
    ref: ref,
  );
});

final FutureProviderFamily<UserModel, String> userDetailsProvider =
    FutureProvider.family((FutureProviderRef<UserModel> ref, String uid) {
  final TweetController tweetController =
      ref.watch(tweetControllerProvider.notifier);
  return tweetController.getUserData(uid);
});

final FutureProvider<UserModel?> currentUserDetailsProvider =
    FutureProvider<UserModel?>((FutureProviderRef<UserModel?> ref) {
  final String currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final AsyncValue<UserModel> userDetails =
      ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final FutureProvider<List<Tweet>> getTweetsProvider =
    FutureProvider<List<Tweet>>((FutureProviderRef<List<Tweet>> ref) async {
  final TweetController tweetController =
      ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

final AutoDisposeStreamProvider<RealtimeMessage> getLatestTweetProvider =
    StreamProvider.autoDispose<RealtimeMessage>(
        (StreamProviderRef<RealtimeMessage> ref) {
  final GetLatestTweetUseCase getLatestTweetUseCase =
      ref.watch(getLatestTweetUseCaseProvider);
  return getLatestTweetUseCase.invoke(NoParams());
});

class TweetController extends StateNotifier<bool> {
  TweetController({
    required GetUserDataUseCase getUserDataUseCase,
    required ShareTweetUseCase shareTweetUseCase,
    required UploadImageUseCase uploadImageUseCase,
    required GetTweetsUseCase getTweetsUseCase,
    required LikeTweetUseCase likeTweetUseCase,
    required Ref ref,
  })  : _getUserDataUseCase = getUserDataUseCase,
        _shareTweetUseCase = shareTweetUseCase,
        _uploadImageUseCase = uploadImageUseCase,
        _getTweetsUseCase = getTweetsUseCase,
        _likeTweetUseCase = likeTweetUseCase,
        _ref = ref,
        super(false);

  final GetUserDataUseCase _getUserDataUseCase;
  final ShareTweetUseCase _shareTweetUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final GetTweetsUseCase _getTweetsUseCase;
  final LikeTweetUseCase _likeTweetUseCase;
  final Ref _ref;

  Future<UserModel> getUserData(String uid) async {
    return _getUserDataUseCase.invoke(uid);
  }

  Future<void> likeTweet(Tweet tweet, UserModel userModel) async {
    final List<String> likes = tweet.likes;
    if (tweet.likes.contains(userModel.uid)) {
      likes.remove(userModel.uid);
    } else {
      likes.add(userModel.uid);
    }
    tweet = tweet.copyWith(
      likes: likes,
    );
    final Either<Failure, model.Document> response =
        await _likeTweetUseCase.invoke(tweet);
    response.fold((_) => null, (_) => null);
  }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }
    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextTweet(
        context: context,
        text: text,
      );
    }
  }

  Future<List<Tweet>> getTweets() async {
    final List<model.Document> tweetList =
        await _getTweetsUseCase.invoke(NoParams());
    return tweetList
        .map((model.Document tweet) => Tweet.fromMap(tweet.data))
        .toList();
  }

  Future<void> _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final List<String> hashTags = _getHashTagsFromText(text);
    final String link = _getLinkFromText(text);
    final UserModel user = _ref.read(currentUserDetailsProvider).value!;
    final List<String> imageLinks = await _uploadImageUseCase.invoke(images);
    final Tweet tweet = Tweet(
      text: text,
      hashtags: hashTags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: const <String>[],
      commentIds: const <String>[],
      id: '',
      reshareCount: 0,
    );
    final Either<Failure, model.Document> response =
        await _shareTweetUseCase.invoke(tweet);
    state = false;
    response.fold((Failure l) => showSnackBar(context, l.message),
        (model.Document r) {
      context.popRoute();
    });
  }

  Future<void> _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final List<String> hashTags = _getHashTagsFromText(text);
    final String link = _getLinkFromText(text);
    final UserModel user = _ref.read(currentUserDetailsProvider).value!;
    final Tweet tweet = Tweet(
      text: text,
      hashtags: hashTags,
      link: link,
      imageLinks: const <String>[],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const <String>[],
      commentIds: const <String>[],
      id: '',
      reshareCount: 0,
    );
    final Either<Failure, model.Document> response =
        await _shareTweetUseCase.invoke(tweet);
    state = false;
    response.fold((Failure l) => showSnackBar(context, l.message),
        (model.Document r) {
      context.popRoute();
    });
  }

  String _getLinkFromText(String text) {
    final List<String> wordsInText = text.split(' ');
    String extractedLink = '';
    for (final String word in wordsInText) {
      if (ifUrl(word)) {
        extractedLink = word;
      }
    }
    return extractedLink;
  }

  List<String> _getHashTagsFromText(String text) {
    final List<String> wordsInText = text.split(' ');
    final List<String> extractedHashTags = List<String>.empty(growable: true);
    for (final String word in wordsInText) {
      if (word.startsWith('#')) {
        extractedHashTags.add(word);
      }
    }
    return extractedHashTags;
  }
}
