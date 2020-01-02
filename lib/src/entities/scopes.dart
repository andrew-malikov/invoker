import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/scope_factory.dart';
import 'package:Invoker/src/services/types_service.dart';

import 'package:dartz/dartz.dart';

class Scopes {
  // TODO: describe structure of the map
  final Map<Type, List<InstanceFactory>> _factories;

  final TypesService _typesService = TypesService();

  Scopes(this._factories);

  Scopes.empty() : this({});

  void putIfAbsent(Identifier identifier, ScopeFactory Function() getScope) {
    var contract = identifier.contract.getOrElse(() => identifier.entry);

    if (!_factories.containsKey(contract)) {
      _factories.putIfAbsent(
          contract, () => [InstanceFactory.from(identifier, getScope())]);

      return;
    }

    var bucket = _factories[contract];
    if (bucket.any((factory) {
      if (factory.entry != identifier.entry) {
        return false;
      }

      return identifier.tag
          .map((identifierTag) => factory.tag
              .map((factoryTag) => factoryTag == identifierTag)
              .getOrElse(() => false))
          .getOrElse(() => false);
    })) {
      return;
    }

    bucket.add(InstanceFactory.from(identifier, getScope()));
  }

  bool containsKey(Type contract, Option<String> tag) {
    var bucketKey = _factories.keys.where((factoryContract) =>
        factoryContract == contract ||
        _typesService.isSubtype(contract, factoryContract));

    if (bucketKey.isEmpty) {
      return false;
    }

    return tag.map((existedTag) {
      return _factories[bucketKey.first].any((factory) => factory.tag
          .map((factoryKey) => factoryKey == existedTag)
          .getOrElse(() => false));
    }).getOrElse(() => true);
  }

  Option<InstanceFactory> get(Type contract) {
    var bucketKey = _factories.keys.where((factoryContract) =>
        factoryContract == contract ||
        _typesService.isSubtype(contract, factoryContract));

    if (bucketKey.isEmpty) {
      return None();
    }

    // TODO: return either with error if there are many realizations
    return Some(_factories[bucketKey.first].first);
  }

  Option<InstanceFactory> getByTag(Type contract, String tag) {
    var bucketKey = _factories.keys.where((factoryContract) =>
        factoryContract == contract ||
        _typesService.isSubtype(contract, factoryContract));

    if (bucketKey.isEmpty) {
      return None();
    }

    var matchedFactories = _factories[bucketKey.first].where((factory) =>
        factory.tag
            .map((factoryKey) => factoryKey == tag)
            .getOrElse(() => false));

    if (matchedFactories.isEmpty) {
      return None();
    }

    // TODO: return either with error if there many are realizations
    return Some(matchedFactories.first);
  }

  List<InstanceFactory> getMany(Type contract) {
    var bucketKey = _factories.keys.where((factoryContract) =>
        factoryContract == contract ||
        _typesService.isSubtype(contract, factoryContract));

    if (bucketKey.isEmpty) {
      return [];
    }

    return [..._factories[bucketKey.first]];
  }
}

class InstanceFactory {
  final Type entry;
  final Option<String> tag;
  final ScopeFactory factory;

  InstanceFactory(this.entry, this.tag, this.factory);

  InstanceFactory.from(Identifier identifier, ScopeFactory factory)
      : this(identifier.entry, identifier.tag, factory);
}
