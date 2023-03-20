import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/features/auth/data/data_source/auth_data_source.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepositoryImpl(authDataSource: ref.watch(authDataSourceProvider));

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;
  final AuthDataSource _authDataSource;

  @override
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return right(
          await _authDataSource.signUp(email: email, password: password));
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? e.toString(), stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      return right(
          await _authDataSource.login(email: email, password: password));
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? e.toString(), stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid saveUserData({required UserModel userModel}) async {
    try {
      await _authDataSource.saveUserData(userModel);
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(e.message ?? e.toString(), stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
