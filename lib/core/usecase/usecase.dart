import 'package:twitter_clone/core/typedef/type_defs.dart';

/// Use class `NoParams` when there are no input parameters
abstract class UseCase<T, R> {
  FutureEither<R> invoke(T params);
}

class NoParams {}
