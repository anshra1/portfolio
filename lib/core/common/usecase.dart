//
// ignore_for_file: one_member_abstracts

import 'package:portfolio/core/common/typedefs.dart';

abstract class FutureUseCaseWithParams<T, P> {
  const FutureUseCaseWithParams();
  ResultFuture<T> call(P params);
}

abstract class FutureUseCaseWithoutParams<T> {
  const FutureUseCaseWithoutParams();
  ResultFuture<T> call();
}

abstract class StreamUseCaseWithoutParam<T> {
  const StreamUseCaseWithoutParam();
  ResultStream<T> call();
}

abstract class StreamUseCaseWithParams<T, P> {
  const StreamUseCaseWithParams();
  ResultStream<T> call(P params);
}
