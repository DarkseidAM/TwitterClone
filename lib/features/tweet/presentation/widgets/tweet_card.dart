import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/widgets/common_widgets.dart';
import 'package:twitter_clone/features/tweet/data/models/tweet_model.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/presentation/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/presentation/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/presentation/widgets/hashtag_text.dart';
import 'package:twitter_clone/features/tweet/presentation/widgets/tweet_icon_button.dart';

class TweetCard extends ConsumerWidget {
  const TweetCard({
    super.key,
    required Tweet tweet,
  }) : _tweet = tweet;
  final Tweet _tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(_tweet.uid)).when(
          data: (UserModel user) {
            return Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePic,
                        ),
                        radius: 35,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //retweeted
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              Text(
                                '@${user.name} · ${timeago.format(
                                  _tweet.tweetedAt,
                                  locale: 'en_short',
                                )}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.greyColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          //repliedto
                          HashtagText(
                            text: _tweet.text,
                          ),
                          if (_tweet.tweetType == TweetType.image)
                            CarouselImage(imageLinks: _tweet.imageLinks),
                          if (_tweet.link.isNotEmpty) ...<Widget>[
                            const SizedBox(
                              height: 4,
                            ),
                            AnyLinkPreview(
                              link: 'https://${_tweet.link}',
                              displayDirection:
                                  UIDirection.uiDirectionHorizontal,
                            ),
                          ],
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                TweetIconButton(
                                  pathName: AssetsConstants.viewsIcon,
                                  text: (_tweet.commentIds.length +
                                          _tweet.reshareCount +
                                          _tweet.likes.length)
                                      .toString(),
                                  onTap: () {},
                                ),
                                TweetIconButton(
                                  pathName: AssetsConstants.commentIcon,
                                  text: _tweet.commentIds.length.toString(),
                                  onTap: () {},
                                ),
                                TweetIconButton(
                                  pathName: AssetsConstants.retweetIcon,
                                  text: _tweet.reshareCount.toString(),
                                  onTap: () {},
                                ),
                                TweetIconButton(
                                  pathName: AssetsConstants.likeOutlinedIcon,
                                  text: _tweet.likes.length.toString(),
                                  onTap: () {},
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 25,
                                    color: Pallete.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Pallete.greyColor,
                ),
              ],
            );
          },
          error: (Object error, StackTrace stacktrace) =>
              ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
