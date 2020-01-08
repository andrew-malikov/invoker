import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';

abstract class Producible<T> {
  Either<T, Failure> make();
}
