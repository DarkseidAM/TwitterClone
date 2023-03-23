import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef/failure.dart';
import 'package:twitter_clone/core/utils/constants.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';

final Provider<AuthDataSource> authDataSourceProvider =
    Provider<AuthDataSource>((ProviderRef<AuthDataSource> ref) {
  return AuthDataSourceImpl(
    account: ref.watch(accountProvider),
    db: ref.watch(databasesProvider),
  );
});

abstract class AuthDataSource {
  Future<model.Account> signUp({
    required String email,
    required String password,
  });

  Future<model.Session> login({
    required String email,
    required String password,
  });

  Future<void> saveUserData(UserModel userModel);
}

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({
    required Account account,
    required Databases db,
  })  : _account = account,
        _db = db;

  final Account _account;
  final Databases _db;

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

  @override
  Future<void> saveUserData(UserModel userModel) {
    try {
      return _db.createDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
    } on AppwriteException catch (e, stackTrace) {
      throw Failure(e.message ?? e.toString(), stackTrace);
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }
}
