import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/widgets/common_widgets.dart';
import 'package:twitter_clone/features/tweet/data/models/user_model.dart';
import 'package:twitter_clone/features/tweet/presentation/controller/tweet_controller.dart';

@RoutePage()
class CreateTweetView extends ConsumerStatefulWidget {
  const CreateTweetView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetViewState();
}

class _CreateTweetViewState extends ConsumerState<CreateTweetView> {
  late final GlobalKey<ScaffoldState> _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? currentUser =
        ref.watch(currentUserDetailsProvider).asData?.value;
    return Scaffold(
      appBar: DynamicAppBar(
        globalKey: _globalKey,
        leadingWidget: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: <Widget>[
          RoundedSmallButton(
            onTap: () {},
            label: 'Tweet',
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            currentUser.profilePic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
