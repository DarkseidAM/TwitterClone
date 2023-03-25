import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/core/theme/palette.dart';

class TweetIconButton extends StatelessWidget {
  const TweetIconButton({
    super.key,
    required String pathName,
    required String text,
    required VoidCallback onTap,
  })  : _pathName = pathName,
        _text = text,
        _onTap = onTap;
  final String _pathName;
  final String _text;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            _pathName,
            colorFilter: const ColorFilter.mode(
              Pallete.greyColor,
              BlendMode.srcIn,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            child: Text(
              _text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
