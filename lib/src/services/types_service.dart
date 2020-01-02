import 'dart:mirrors';

class TypesService {
  bool isSubtype(Type parent, Type subtype) {
    return reflectClass(subtype).isSubclassOf(reflectClass(parent));
  }
}
