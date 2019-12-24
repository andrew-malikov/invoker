import 'package:optional/optional.dart';

abstract class Identifier {
  Type get entry;

  Optional<Type> get contract;
  Optional<String> get tag;
}
