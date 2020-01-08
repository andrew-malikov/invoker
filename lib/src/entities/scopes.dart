import 'package:Invoker/src/producible.dart';
import 'package:dartz/dartz.dart';

import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/failure.dart';
import 'package:Invoker/src/entities/failures/contract_failure.dart';

import 'package:Invoker/src/services/metadata/types_service.dart';

class Scopes {
  // TODO: describe structure of the map
  final Map<Type, List<InitializedFactory>> _factories;

  Scopes(this._factories);

  Scopes.empty() : this({});

  void putIfAbsent<T>(
      Identifier identifier, Producible<T> Function() getFactory) {
    var contract = identifier.contract.getOrElse(() => identifier.entry);

    if (!_factories.containsKey(contract)) {
      _factories.putIfAbsent(contract,
          () => [InitializedFactory<T>.from(identifier, getFactory())]);

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

    bucket.add(InitializedFactory<T>.from(identifier, getFactory()));
  }

  bool containsKey(Type contract, Option<String> tag) {
    var bucketKey = _factories.keys
        .where((factoryContract) => factoryContract.isInHierarchy(contract));

    if (bucketKey.isEmpty) {
      return false;
    }

    return tag.map((existedTag) {
      return _factories[bucketKey.first].any((factory) => factory.tag
          .map((factoryKey) => factoryKey == existedTag)
          .getOrElse(() => false));
    }).getOrElse(() => true);
  }

  Either<InitializedFactory, Failure> get(Type contract) {
    var bucketKey = _factories.keys
        .where((factoryContract) => factoryContract.isInHierarchy(contract));

    if (bucketKey.isEmpty) {
      return Right(ContractFailure.Mismatch(contract));
    }

    if (bucketKey.length > 1 || _factories[bucketKey.first].length > 1) {
      return Right(ContractFailure.MulpipleImplementations(contract));
    }

    return Left(_factories[bucketKey.first].first);
  }

  Either<InitializedFactory, Failure> getByTag(Type contract, String tag) {
    var bucketKey = _factories.keys
        .where((factoryContract) => factoryContract.isInHierarchy(contract));

    if (bucketKey.isEmpty) {
      return Right(ContractFailure.Mismatch(contract));
    }

    var matchedFactories = _factories[bucketKey.first].where((factory) =>
        factory.tag
            .map((factoryKey) => factoryKey == tag)
            .getOrElse(() => false));

    if (matchedFactories.isEmpty) {
      return Right(ContractFailure.MismatchByTag(contract, tag));
    }

    return Left(matchedFactories.first);
  }

  List<InitializedFactory> getMany(Type contract) {
    var bucketKey = _factories.keys
        .where((factoryContract) => factoryContract.isInHierarchy(contract));

    if (bucketKey.isEmpty) {
      return [];
    }

    return [..._factories[bucketKey.first]];
  }
}

class InitializedFactory<T> {
  final Type entry;
  final Option<String> tag;
  final Producible<T> factory;

  InitializedFactory(this.entry, this.tag, this.factory);

  InitializedFactory.from(Identifier identifier, Producible<T> factory)
      : this(identifier.entry, identifier.tag, factory);
}
