import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/typedef/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef EitherFailure<T> = Either<Failure, T>;
