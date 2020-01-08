import 'package:dartz/dartz.dart';

import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/builders/container_entry_builder.dart';
import 'package:Invoker/src/entities/scopes.dart';
import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/failure.dart';

import 'package:Invoker/src/services/metadata/objects_service.dart';
import 'package:Invoker/src/services/failure_service.dart';

class DependencyService implements DependencyContainer {
  final Scopes _scopes;

  DependencyService(this._scopes);

  DependencyService.empty() : this(Scopes.empty());

  @override
  BuildableEntry bind<R>() {
    return ContainerEntryBuilder<R>(_registrate, this);
  }

  @override
  BuildableEntry bindWithContract<C, R extends C>() {
    return ContainerEntryBuilder<R>(
        _registrate, this, Some(C.getReflectedType()));
  }

  @override
  Either<C, Failure> resolve<C>() {
    return _resolveByType(C.getReflectedType())
        .leftMap((resolved) => resolved as C);
  }

  @override
  Either<C, Failure> resolveByTag<C>(String tag) {
    return _scopes
        .getByTag(C.getReflectedType(), tag)
        .leftMap((initializedFactory) => initializedFactory.factory.make())
        .flatMapWithFailure()
        .leftMap((resolved) => resolved as C);
  }

  DependencyContainer _registrate(
      Identifier identifier, BuildScope buildScope) {
    _scopes.putIfAbsent(identifier, () => buildScope(_resolveByType));

    return this;
  }

  Either<dynamic, Failure> _resolveByType(Type type) {
    return _scopes
        .get(type)
        .leftMap((initializedFactory) => initializedFactory.factory.make())
        .flatMapWithFailure();
  }
}
