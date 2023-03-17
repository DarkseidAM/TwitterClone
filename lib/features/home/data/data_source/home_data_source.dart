import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/providers.dart';

part 'home_data_source.g.dart';

@riverpod
HomeDataSource homeDataSource(HomeDataSourceRef ref) =>
    HomeDataSourceImpl(account: ref.watch(accountProvider));

abstract class HomeDataSource {
  Future<model.Account?> currentUserAccount();
}

class HomeDataSourceImpl implements HomeDataSource {
  const HomeDataSourceImpl({required Account account}) : _account = account;

  final Account _account;

  @override
  Future<model.Account?> currentUserAccount() async {
    try {
      return _account.get();
    } catch (e) {
      return null;
    }
  }
}
