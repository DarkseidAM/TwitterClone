import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';

final Provider<HomeDataSource> homeDataSourceProvider =
    Provider<HomeDataSource>((ProviderRef<HomeDataSource> ref) {
  return HomeDataSourceImpl(
    account: ref.watch(accountProvider),
  );
});

abstract class HomeDataSource {
  Future<User?> currentUserAccount();
}

class HomeDataSourceImpl implements HomeDataSource {
  const HomeDataSourceImpl({
    required Account account,
  }) : _account = account;

  final Account _account;

  @override
  Future<User?> currentUserAccount() async {
    try {
      return _account.get();
    } catch (e) {
      return null;
    }
  }
}
