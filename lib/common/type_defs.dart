import 'package:fpdart/fpdart.dart';
import 'package:turf_together/common/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
