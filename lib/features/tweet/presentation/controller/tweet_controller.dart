import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/home/presentation/controller/home_controller.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/domain/usecases/get_user_data_usecase.dart';

final StateNotifierProvider<TweetController, bool> tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>(
        (StateNotifierProviderRef<TweetController, bool> ref) {
  return TweetController(
    getUserDataUseCase: ref.watch(getUserDataUseCaseProvider),
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

class TweetController extends StateNotifier<bool> {
  TweetController({
    required GetUserDataUseCase getUserDataUseCase,
  })  : _getUserDataUseCase = getUserDataUseCase,
        super(false);

  final GetUserDataUseCase _getUserDataUseCase;

  Future<UserModel> getUserData(String uid) async {
    return _getUserDataUseCase.invoke(uid);
  }
}
