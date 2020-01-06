import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';

abstract class Producible {
  Either<dynamic, Failure> make();
}
