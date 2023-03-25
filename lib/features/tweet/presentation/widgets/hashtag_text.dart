import 'package:flutter/material.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/common_utils.dart';

class HashtagText extends StatelessWidget {
  const HashtagText({
    super.key,
    required String text,
  }) : _text = text;
  final String _text;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = List<TextSpan>.empty(growable: true);
    _text.split(' ').forEach((String element) {
      if (element.startsWith('#')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else if (ifUrl(element)) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        );
      }
    });
    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
