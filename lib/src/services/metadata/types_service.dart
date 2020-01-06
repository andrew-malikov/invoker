import 'dart:mirrors';

extension TypeService on Type {
  bool isInHierarchy(Type check) =>
      reflectType(this).isAssignableTo(reflectType(check));
}
