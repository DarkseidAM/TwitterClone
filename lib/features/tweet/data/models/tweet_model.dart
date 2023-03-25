// ignore_for_file: argument_type_not_assignable, avoid_dynamic_calls

import 'package:flutter/foundation.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

@immutable
class Tweet {
  const Tweet({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
    // required this.retweetedBy,
    // required this.repliedTo,
  });

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map[r'$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
      // rětweetedBy: map['retweetedBy'] ?? '',
      // repliedTo: map['repliedTo'] ?? '',
    );
  }
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  // final String retweetedBy;
  // final String repliedTo;

  Tweet copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
    // String? retweetedBy,
    // String? repliedTo,
  }) {
    return Tweet(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
      // retweetedBy: retweetedBy ?? this.retweetedBy,
      // repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = <String, dynamic>{};

    result.addAll(<String, dynamic>{'text': text});
    result.addAll(<String, dynamic>{'hashtags': hashtags});
    result.addAll(<String, dynamic>{'link': link});
    result.addAll(<String, dynamic>{'imageLinks': imageLinks});
    result.addAll(<String, dynamic>{'uid': uid});
    result.addAll(<String, dynamic>{'tweetType': tweetType.type});
    result.addAll(
        <String, dynamic>{'tweetedAt': tweetedAt.millisecondsSinceEpoch});
    result.addAll(<String, dynamic>{'likes': likes});
    result.addAll(<String, dynamic>{'commentIds': commentIds});
    result.addAll(<String, dynamic>{'reshareCount': reshareCount});
    // result.addAll(<String, dynamic>{'retweetedBy': retweetedBy});
    // result.addAll(<String, dynamic>{'repliedTo': repliedTo});

    return result;
  }

  @override
  String toString() {
    return 'Tweet(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Tweet &&
        other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.tweetType == tweetType &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount;
    // other.retweetedBy == retweetedBy &&
    // other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        tweetType.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode;
    // retweetedBy.hashCode ^
    // repliedTo.hashCode;
  }
}
