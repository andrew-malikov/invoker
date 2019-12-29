import 'dart:mirrors';

import 'package:dartz/dartz.dart';

typedef ProvideArg = Option Function(Type);

class InstanceFactory {
  final ProvideArg _provideArg;

  InstanceFactory(this._provideArg);

  Option<dynamic> makeByArgs(Type instanceType, List<Type> argsDeclarations) {
    final resolvedArgs = argsDeclarations
        .map((declaration) => _provideArg(declaration))
        .where((arg) => arg.isSome())
        .fold<List<dynamic>>([], (args, arg) => args + arg.toIterable());

    // TODO: provide detailed resolved data
    if (resolvedArgs.length != argsDeclarations.length) {
      return None();
    }

    return Some(reflectClass(instanceType)
        .newInstance(Symbol.empty, resolvedArgs)
        .reflectee);
  }
}
