import 'package:appwrite/appwrite.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/widgets/error_view.dart';
import 'package:twitter_clone/core/widgets/loading_view.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/presentation/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/presentation/widgets/tweet_card.dart';

@RoutePage(
  name: 'TweetListRoute',
)
class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (List<Tweet> tweets) {
            return ref.watch(getLatestTweetProvider).when(
                  data: (RealtimeMessage data) {
                    if (data.events.contains(
                      'databases.*.collections.${AppWriteConstants.tweetsCollection}.documents.*.create',
                    )) {
                      tweets.insert(0, Tweet.fromMap(data.payload));
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final Tweet tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      },
                      itemCount: tweets.length,
                    );
                  },
                  error: (Object error, StackTrace stackTrace) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final Tweet tweet = tweets[index];
                      return TweetCard(tweet: tweet);
                    },
                    itemCount: tweets.length,
                  ),
                );
          },
          error: (Object error, StackTrace stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
