import 'package:appwrite/models.dart';

abstract class HomeRepository {
  Future<User?> currentUserAccount();
}
