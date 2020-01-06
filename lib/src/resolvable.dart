import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';

abstract class Resolvable {
  Either<C, Failure> resolve<C>();
  Either<C, Failure> resolveByTag<C>(String tag);
}

typedef Resolve = Either<dynamic, Failure> Function(Type);
