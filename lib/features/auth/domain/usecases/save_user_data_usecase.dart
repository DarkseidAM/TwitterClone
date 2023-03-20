import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/auth/data/models/user_model.dart';
import 'package:twitter_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

part 'save_user_data_usecase.g.dart';

@riverpod
SaveUserDataUseCase saveUserDataUseCase(SaveUserDataUseCaseRef ref) =>
    SaveUserDataUseCase(authRepository: ref.watch(authRepositoryProvider));

class SaveUserDataUseCase implements EitherUseCase<UserModel, void> {
  const SaveUserDataUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  FutureEither<void> invoke(UserModel params) {
    return _authRepository.saveUserData(userModel: params);
  }
}
