import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/features/home/data/data_source/home_data_source.dart';
import 'package:twitter_clone/features/home/domain/repository/home_repository.dart';

part 'home_repository_impl.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) =>
    HomeRepositoryImpl(homeDataSource: ref.watch(homeDataSourceProvider));

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required HomeDataSource homeDataSource})
      : _homeDataSource = homeDataSource;
  final HomeDataSource _homeDataSource;

  @override
  Future<model.Account?> currentUserAccount() async {
    try {
      return await _homeDataSource.currentUserAccount();
    } catch (e) {
      return null;
    }
  }
}
