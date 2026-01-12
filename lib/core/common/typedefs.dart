import 'package:fpdart/fpdart.dart';
import 'package:portfolio/core/error/error.dart';


typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
