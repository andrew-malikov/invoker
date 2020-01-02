import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/entities/immutable_identifier.dart';
import 'package:Invoker/src/factories/scopes/singleton_factory.dart';
import 'package:Invoker/src/factories/scopes/transient_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/services/dependency_resolvable_service.dart';

import 'package:dartz/dartz.dart';

class ContainerEntryBuilder implements BuildableEntry {
  final Registrate _registrate;
  DependencyResolvableService _dependencyResolvable;

  Identifier _identifier;

  ContainerEntryBuilder(Type entry, Option<Type> contract, this._registrate) {
    _dependencyResolvable = DependencyResolvableService();
    _identifier = ImmutableIdentifier(entry, contract, None());
  }

  @override
  void withTag(String tag) {
    _identifier =
        ImmutableIdentifier(_identifier.entry, _identifier.contract, Some(tag));
  }

  @override
  DependencyContainer asSingleton() {
    return _registrate(
        _identifier,
        (resolve) => SingletonFactory(_identifier,
            _dependencyResolvable.resolve(_identifier.entry), resolve));
  }

  @override
  DependencyContainer asTransient() {
    return _registrate(
        _identifier,
        (resolve) => TransientFactory(_identifier,
            _dependencyResolvable.resolve(_identifier.entry), resolve));
  }
}
