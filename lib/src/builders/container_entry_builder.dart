import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/container.dart';
import 'package:Invoker/src/entities/immutable_identifier.dart';
import 'package:Invoker/src/factories/scopes/singleton_factory.dart';
import 'package:Invoker/src/factories/scopes/transient_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/services/dependency_resolvable_service.dart';

import 'package:dartz/dartz.dart';

class ContainerEntryBuilder implements BuildableEntry {
  final Registrate _registrate;
  DependencyResolvableService _dependencyResolvable;

  Identifier _entryIdentifier;

  ContainerEntryBuilder(Type entry, this._registrate) {
    _dependencyResolvable = DependencyResolvableService();
    _entryIdentifier = ImmutableIdentifier(entry, None(), None());
  }

  @override
  void withContract<C>() {
    _entryIdentifier = ImmutableIdentifier(
        _entryIdentifier.entry, Some(C.runtimeType), _entryIdentifier.tag);
  }

  @override
  void withTag(String tag) {
    _entryIdentifier = ImmutableIdentifier(
        _entryIdentifier.entry, _entryIdentifier.contract, Some(tag));
  }

  @override
  Container asSingleton() {
    return _registrate(
        _entryIdentifier,
        (resolve) => SingletonFactory(_entryIdentifier,
            _dependencyResolvable.resolve(_entryIdentifier.entry), resolve));
  }

  @override
  Container asTransient() {
    return _registrate(
        _entryIdentifier,
        (resolve) => TransientFactory(_entryIdentifier,
            _dependencyResolvable.resolve(_entryIdentifier.entry), resolve));
  }
}
