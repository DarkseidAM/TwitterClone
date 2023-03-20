import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });

  FutureEither<model.Session> login({
    required String email,
    required String password,
  });

  FutureEitherVoid saveUserData({
    required UserModel userModel,
  });
}
