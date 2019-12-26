import 'dart:mirrors';

import 'package:dartz/dartz.dart';

typedef ProvideArg = Option<dynamic> Function(Type);

class ObjectFactory {
  final ProvideArg _provideArg;

  ObjectFactory(this._provideArg);

  Option<dynamic> makeByArgs(Type instanceType, List<Type> argsDeclarations) {
    final resolvedArgs = argsDeclarations
        .map((declaration) => _provideArg(declaration))
        .where((arg) => arg.isSome())
        .fold<List<dynamic>>([], (args, arg) => args + [arg]);

    if (resolvedArgs.length != argsDeclarations.length) {
      return None();
    }

    return Some(
        reflectClass(instanceType).newInstance(Symbol.empty, resolvedArgs));
  }
}
