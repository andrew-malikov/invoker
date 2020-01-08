import 'package:dartz/dartz.dart';

import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/resolvable.dart';
import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/entities/immutable_identifier.dart';
import 'package:Invoker/src/factories/scopes/singleton_factory.dart';
import 'package:Invoker/src/factories/scopes/transient_factory.dart';
import 'package:Invoker/src/factories/scopes/provided_factory.dart';
import 'package:Invoker/src/identifier.dart';

import 'package:Invoker/src/services/metadata/objects_service.dart';
import 'package:Invoker/src/services/metadata/constructors_service.dart';

class ContainerEntryBuilder<T> implements BuildableEntry<T> {
  final Registrate _registrate;
  final Resolvable _resolvable;

  Identifier _identifier;
  Option<Produce<T>> _produce;

  ContainerEntryBuilder(this._registrate, this._resolvable,
      [Option<Type> contract]) {
    _identifier =
        ImmutableIdentifier(T.getReflectedType(), contract ?? None(), None());
    _produce = None();
  }

  @override
  void withTag(String tag) {
    _identifier =
        ImmutableIdentifier(_identifier.entry, _identifier.contract, Some(tag));
  }

  @override
  void withFactory(Produce<T> produce) {
    _produce = Some(produce);
  }

  @override
  DependencyContainer asSingleton() {
    return _registrate(
        _identifier, (resolve) => SingletonFactory<T>(_getFactory(resolve)));
  }

  @override
  DependencyContainer asTransient() {
    return _registrate(_identifier, (resolve) => _getFactory(resolve));
  }

  Producible<T> _getFactory(Resolve resolve) {
    final factory = _produce.map(
        (produce) => ProvidedFactory(produce, _resolvable) as Producible<T>);

    return factory.getOrElse(() =>
        TransientFactory<T>(_identifier, _identifier.entry.getArgs(), resolve));
  }
}
