import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
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
    final UserModel? currentUser =
        ref.watch(currentUserDetailsProvider).asData?.value;
    return currentUser == null
        ? const Loader()
        : ref.watch(userDetailsProvider(_tweet.uid)).when(
              data: (UserModel user) {
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            imageUrl: user.profilePic,
                            imageBuilder:
                                (_, ImageProvider<Object> imageProvider) =>
                                    CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: 35,
                            ),
                            placeholder: (_, __) => Container(
                              color: Colors.black,
                            ),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (_tweet.retweetedBy.isNotEmpty)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      AssetsConstants.retweetIcon,
                                      colorFilter: const ColorFilter.mode(
                                        Pallete.greyColor,
                                        BlendMode.srcIn,
                                      ),
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '${_tweet.retweetedBy} retweeted',
                                      style: const TextStyle(
                                        color: Pallete.greyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
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
                                margin:
                                    const EdgeInsets.only(top: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      onTap: () {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .reshareTweet(
                                                _tweet, currentUser, context);
                                      },
                                    ),
                                    LikeButton(
                                      size: 25,
                                      onTap: (bool isLiked) async {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .likeTweet(_tweet, currentUser);
                                        return !isLiked;
                                      },
                                      isLiked: _tweet.likes
                                          .contains(currentUser.uid),
                                      likeBuilder: (bool isLiked) {
                                        return isLiked
                                            ? SvgPicture.asset(
                                                AssetsConstants.likeFilledIcon,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Pallete.redColor,
                                                  BlendMode.srcIn,
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                AssetsConstants
                                                    .likeOutlinedIcon,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Pallete.greyColor,
                                                  BlendMode.srcIn,
                                                ));
                                      },
                                      likeCount: _tweet.likes.length,
                                      countBuilder:
                                          (_, bool isLiked, String text) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                              color: isLiked
                                                  ? Pallete.redColor
                                                  : Pallete.whiteColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
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
