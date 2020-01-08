import 'dart:mirrors';

import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';

typedef ProvideArg = Either<dynamic, Failure> Function(Type);

class ObjectsFactory {
  final ProvideArg _provideArg;

  ObjectsFactory(this._provideArg);

  Either<T, Failure> makeByArgs<T>(
      Type instanceType, List<Type> argsDeclarations) {
    final resolvedDependencies = [];

    for (var argDeclaration in argsDeclarations) {
      final resolvedDependency = _provideArg(argDeclaration);

      if (resolvedDependency.isRight()) {
        return Right((resolvedDependency as Right).value);
      }

      resolvedDependency.fold(
          (dependency) => resolvedDependencies.add(dependency), right);
    }

    return Left(reflectClass(instanceType)
        .newInstance(Symbol.empty, resolvedDependencies)
        .reflectee as T);
  }
}
