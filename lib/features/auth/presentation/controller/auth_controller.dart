import 'package:appwrite/models.dart' as model;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:twitter_clone/core/navigation/app_router.gr.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/utils/common_utils.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';
import 'package:twitter_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/save_user_data_usecase.dart';
import 'package:twitter_clone/features/auth/domain/usecases/sign_up_usecase.dart';

final StateNotifierProvider<AuthController, bool> authControllerProvider =
    StateNotifierProvider<AuthController, bool>(
        (StateNotifierProviderRef<AuthController, bool> ref) {
  return AuthController(
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    loginUseCase: ref.watch(loginUseCaseProvider),
    saveUserDataUseCase: ref.watch(saveUserDataUseCaseProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  AuthController(
      {required SignUpUseCase signUpUseCase,
      required LoginUseCase loginUseCase,
      required SaveUserDataUseCase saveUserDataUseCase})
      : _signUpUseCase = signUpUseCase,
        _loginUseCase = loginUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        super(false);
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

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
      (model.Account r) async {
        final UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: List<String>.empty(),
          following: List<String>.empty(),
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isTwitterBlue: false,
        );
        final EitherFailure<void> response =
            await _saveUserDataUseCase.invoke(userModel);
        response.fold(
          (Failure l) => showSnackBar(context, l.message),
          (_) {
            showSnackBar(context, 'Account Created! Please login.');
            context.router.pop();
          },
        );
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
        context.router.replace(const HomeRoute());
      },
    );
  }
}
