import 'package:appwrite/models.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  FutureEither<User> signUp({
    required String email,
    required String password,
  });

  FutureEither<Session> login({
    required String email,
    required String password,
  });

  FutureEitherVoid saveUserData({
    required UserModel userModel,
  });
}
