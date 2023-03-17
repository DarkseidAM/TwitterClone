import 'package:appwrite/models.dart' as model;

abstract class HomeRepository {
  Future<model.Account?> currentUserAccount();
}
