import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/builders/container_entry_builder.dart';
import 'package:Invoker/src/entities/scopes.dart';
import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/identifier.dart';

import 'package:dartz/dartz.dart';

class DependencyService implements DependencyContainer {
  final Scopes _scopes;

  DependencyService(this._scopes);

  DependencyService.empty() : this(Scopes.empty());

  @override
  BuildableEntry bind<R>() {
    return ContainerEntryBuilder(R.runtimeType, None(), _registrate);
  }

  @override
  BuildableEntry bindWithContract<C, R extends C>() {
    return ContainerEntryBuilder(
        R.runtimeType, Some(C.runtimeType), _registrate);
  }

  @override
  Option<C> resolve<C>() {
    // TODO: implement resolve
    return null;
  }

  @override
  Option<C> resolveByTag<C>(String tag) {
    // TODO: implement resolveByTag
    return null;
  }

  DependencyContainer _registrate(
      Identifier identifier, BuildScope buildScope) {
    _scopes.putIfAbsent(identifier, () => buildScope(_resolveByType));

    return this;
  }

  Option _resolveByType(Type type) {
    return _scopes
        .get(type)
        .map((factoryInstance) => factoryInstance.factory.make());
  }
}
