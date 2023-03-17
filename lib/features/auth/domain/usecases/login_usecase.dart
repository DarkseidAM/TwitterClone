import 'package:appwrite/models.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

part 'login_usecase.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) =>
    LoginUseCase(authRepository: ref.watch(authRepositoryProvider));

class LoginUseCase
    implements EitherUseCase<Tuple2<String, String>, model.Session> {
  const LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  FutureEither<model.Session> invoke(Tuple2<String, String> params) {
    return _authRepository.login(email: params.item1, password: params.item2);
  }
}
