import 'dart:mirrors';

extension ObjectsService on Object {
  Type getReflectedType() => reflectType(this).reflectedType;
}
