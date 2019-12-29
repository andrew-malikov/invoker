import 'dart:mirrors';

import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/entities/immutable_dependency.dart';

class DependencyResolvableService {
  List<Dependency> resolve(Type type) {
    final constructors = reflectClass(type)
        .instanceMembers
        .entries
        .where((declaration) => declaration.value.isConstructor);

    if (constructors.isEmpty) {
      return [];
    }

    return constructors.first.value.parameters
        .where((parameter) => !parameter.isOptional)
        .map((parameter) => ImmutableDependency(parameter.type.reflectedType))
        .toList();
  }
}
