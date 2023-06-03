import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/constants.dart';

class DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicAppBar({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
    Widget? leadingWidget,
    List<Widget>? actions,
  })  : _leadingWidget = leadingWidget,
        _actions = actions,
        _globalKey = globalKey;

  final Widget? _leadingWidget;
  final List<Widget>? _actions;
  final GlobalKey<ScaffoldState> _globalKey;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(
        double.maxFinite,
        Scaffold.of(context).appBarMaxHeight ?? 56,
      ),
      child: AppBar(
        title: SvgPicture.asset(
          AssetsConstants.twitterLogo,
          colorFilter: const ColorFilter.mode(
            Pallete.blueColor,
            BlendMode.srcIn,
          ),
          height: 30,
        ),
        centerTitle: true,
        leading: _leadingWidget,
        actions: _actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        _globalKey.currentState?.appBarMaxHeight ?? 56,
      );
}
