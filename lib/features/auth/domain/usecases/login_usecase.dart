import 'package:appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';
import 'package:twitter_clone/core/typedef/type_defs.dart';
import 'package:twitter_clone/core/usecase/usecase.dart';
import 'package:twitter_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:twitter_clone/features/auth/domain/repository/auth_repository.dart';

final Provider<LoginUseCase> loginUseCaseProvider =
    Provider<LoginUseCase>((ProviderRef<LoginUseCase> ref) {
  return LoginUseCase(authRepository: ref.watch(authRepositoryProvider));
});

class LoginUseCase implements EitherUseCase<Tuple2<String, String>, Session> {
  const LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  final AuthRepository _authRepository;

  @override
  FutureEither<Session> invoke(Tuple2<String, String> params) {
    return _authRepository.login(email: params.item1, password: params.item2);
  }
}
