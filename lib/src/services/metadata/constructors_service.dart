import 'dart:mirrors';

import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/entities/immutable_dependency.dart';

extension ConstructorsService on Type {
  List<Dependency> getArgs() {
    final constructors = reflectClass(this)
        .declarations
        .values
        .whereType<MethodMirror>()
        .where((declaration) => declaration.isConstructor)
        .toList();

    if (constructors.isEmpty) {
      return [];
    }

    return constructors.first.parameters
        .where((parameter) => !parameter.isOptional)
        .map((parameter) => ImmutableDependency(parameter.type.reflectedType))
        .toList();
  }
}
