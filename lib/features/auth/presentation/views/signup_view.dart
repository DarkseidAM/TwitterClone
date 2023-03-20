import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/theme/theme.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/core/widgets/common_widgets.dart';
import 'package:twitter_clone/features/auth/presentation/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/presentation/widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends ConsumerState<SignUpView> {
  final AppBar appBar = UIConstants.appBar();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: <Widget>[
                    AuthField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: RoundedSmallButton(
                        onTap: onSignUp,
                        label: 'Done',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' Login',
                            style: const TextStyle(
                              color: Pallete.blueColor,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.router.pop();
                              },
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}
