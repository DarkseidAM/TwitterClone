import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:twitter_clone/core/navigation/router_constants.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/utils/common_utils.dart';
import 'package:twitter_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/sign_up_usecase.dart';

final AutoDisposeStateNotifierProvider<AuthController, bool>
    authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, bool>(
        (StateNotifierProviderRef<AuthController, bool> ref) {
  return AuthController(
    signUpUseCase: ref.read(signUpUseCaseProvider),
    loginUseCase: ref.read(loginUseCaseProvider),
    logger: ref.read(loggerProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  AuthController({
    required SignUpUseCase signUpUseCase,
    required LoginUseCase loginUseCase,
    required Logger logger,
  })  : _signUpUseCase = signUpUseCase,
        _loginUseCase = loginUseCase,
        _logger = logger,
        super(false);
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final Logger _logger;

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final EitherFailure<model.Account> response =
        await _signUpUseCase.invoke(Tuple2<String, String>(email, password));
    state = false;
    response.fold(
      (Failure l) => showSnackBar(context, l.message),
      (model.Account r) {
        _logger.d(r.email);
        showSnackBar(context, 'Account Created! Please login.');
        context.push(loginRoute);
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final EitherFailure<model.Session> response =
        await _loginUseCase.invoke(Tuple2<String, String>(email, password));
    state = false;
    response.fold(
      (Failure l) => showSnackBar(context, l.message),
      (model.Session r) {
        _logger.d(r.userId);
        context.push(homeRoute);
      },
    );
  }
}
