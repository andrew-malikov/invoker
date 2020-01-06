import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';

extension FailureService<D extends Either, F extends Failure> on Either<D, F> {
  Either<L, F> flatMapWithFailure<L>() {
    var mapped;

    fold((left) => mapped = left, (right) => mapped = Right(right));

    return mapped;
  }
}
