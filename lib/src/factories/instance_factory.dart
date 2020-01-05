import 'dart:mirrors';

import 'package:dartz/dartz.dart';

typedef ProvideArg = Option Function(Type);

class InstanceFactory {
  final ProvideArg _provideArg;

  InstanceFactory(this._provideArg);

  // TODO: provide detailed exception metadata
  Option<dynamic> makeByArgs(Type instanceType, List<Type> argsDeclarations) {
    final resolvedArgs = argsDeclarations
        .map((declaration) => _provideArg(declaration))
        .where((arg) => arg.isSome())
        .fold<List<dynamic>>(
            [], (args, arg) => [...args, arg.toIterable().first]);

    return Some(reflectClass(instanceType)
        .newInstance(Symbol.empty, resolvedArgs)
        .reflectee);
  }
}
