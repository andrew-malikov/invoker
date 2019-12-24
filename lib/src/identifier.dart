import 'package:optional/optional.dart';

abstract class Identifier {
  Type entry;

  Optional<Type> contract;
  Optional<String> name;
}
