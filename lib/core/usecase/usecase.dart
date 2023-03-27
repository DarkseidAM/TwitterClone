import 'package:twitter_clone/core/typedef/type_defs.dart';

/// Use class `NoParams` when there are no input parameters
abstract class EitherUseCase<T, R> {
  FutureEither<R> invoke(T params);
}

/// Use class `NoParams` when there are no input parameters
abstract class UseCase<T, R> {
  Future<R> invoke(T params);
}

/// Use class `NoParams` when there are no input parameters
abstract class StreamUseCase<T, R> {
  Stream<R> invoke(T params);
}

class NoParams {}
