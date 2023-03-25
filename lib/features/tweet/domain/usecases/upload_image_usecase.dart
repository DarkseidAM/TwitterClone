import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/tweet/data/repository/tweet_repository_impl.dart';
import 'package:twitter_clone/features/tweet/domain/repository/tweet_repository.dart';

final Provider<UploadImageUseCase> uploadImageUseCaseProvider =
    Provider<UploadImageUseCase>((ProviderRef<UploadImageUseCase> ref) {
  return UploadImageUseCase(
      tweetRepository: ref.watch(tweetRepositoryProvider));
});

class UploadImageUseCase implements UseCase<List<File>, List<String>> {
  const UploadImageUseCase({required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  final TweetRepository _tweetRepository;

  @override
  Future<List<String>> invoke(List<File> params) {
    return _tweetRepository.uploadImage(params);
  }
}
