import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/widgets/dynamic_app_bar.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final GlobalKey<ScaffoldState> _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      key: _globalKey,
      routes: const <PageRouteInfo>[
        TweetListRoute(),
        EmptyRoute(),
        EmptyRoute(),
      ],
      appBarBuilder: (_, __) => DynamicAppBar(
        globalKey: _globalKey,
        leadingWidget: const AutoLeadingButton(),
      ),
      bottomNavigationBuilder: (_, TabsRouter tabsRouter) => CupertinoTabBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        backgroundColor: Pallete.backgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.homeOutlinedIcon,
              colorFilter: const ColorFilter.mode(
                Pallete.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsConstants.homeFilledIcon,
              colorFilter: const ColorFilter.mode(
                Pallete.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              colorFilter: const ColorFilter.mode(
                Pallete.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.notifOutlinedIcon,
              colorFilter: const ColorFilter.mode(
                Pallete.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AssetsConstants.notifFilledIcon,
              colorFilter: const ColorFilter.mode(
                Pallete.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CreateTweetRoute());
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
    );
  }
}
