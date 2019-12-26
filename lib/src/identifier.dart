import 'package:dartz/dartz.dart';

abstract class Identifier {
  Type get entry;

  Option<Type> get contract;
  Option<String> get tag;
}
