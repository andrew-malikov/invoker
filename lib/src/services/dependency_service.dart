import 'package:dartz/dartz.dart';

import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/builders/container_entry_builder.dart';
import 'package:Invoker/src/entities/scopes.dart';
import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/identifier.dart';

import 'package:Invoker/src/services/metadata/objects_service.dart';

class DependencyService implements DependencyContainer {
  final Scopes _scopes;

  DependencyService(this._scopes);

  DependencyService.empty() : this(Scopes.empty());

  @override
  BuildableEntry bind<R>() {
    return ContainerEntryBuilder(R.getReflectedType(), None(), _registrate);
  }

  @override
  BuildableEntry bindWithContract<C, R extends C>() {
    return ContainerEntryBuilder(
        R.getReflectedType(), Some(C.getReflectedType()), _registrate);
  }

  @override
  Option<C> resolve<C>() {
    return _resolveByType(C.getReflectedType())
        .map((resolved) => resolved as C);
  }

  @override
  Option<C> resolveByTag<C>(String tag) {
    return _scopes
        .getByTag(C.getReflectedType(), tag)
        .flatMap((factoryInstance) => factoryInstance.factory.make())
        .map((resolved) => resolved as C);
  }

  DependencyContainer _registrate(
      Identifier identifier, BuildScope buildScope) {
    _scopes.putIfAbsent(identifier, () => buildScope(_resolveByType));

    return this;
  }

  Option _resolveByType(Type type) {
    return _scopes
        .get(type)
        .flatMap((factoryInstance) => factoryInstance.factory.make());
  }
}
