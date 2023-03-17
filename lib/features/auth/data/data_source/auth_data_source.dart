import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef/failure.dart';

part 'auth_data_source.g.dart';

@riverpod
AuthDataSource authDataSource(AuthDataSourceRef ref) =>
    AuthDataSourceImpl(account: ref.watch(accountProvider));

abstract class AuthDataSource {
  Future<model.Account> signUp({
    required String email,
    required String password,
  });

  Future<model.Session> login({
    required String email,
    required String password,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({required Account account}) : _account = account;

  final Account _account;

  @override
  Future<model.Account> signUp(
      {required String email, required String password}) {
    try {
      return _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  @override
  Future<model.Session> login({
    required String email,
    required String password,
  }) {
    try {
      return _account.createEmailSession(
        email: email,
        password: password,
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }
}
