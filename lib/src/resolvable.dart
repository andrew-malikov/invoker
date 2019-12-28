import 'package:dartz/dartz.dart';

abstract class Resolvable {
  Option<C> resolve<C>();
  Option<C> resolveByTag<C>(String tag);
}

typedef Resolve = Option Function(Type);
