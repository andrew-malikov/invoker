import 'package:dartz/dartz.dart';

import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/failure.dart';
import 'package:Invoker/src/factories/objects_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/scope_factory.dart';
import 'package:Invoker/src/resolvable.dart';

class TransientFactory<T> implements ScopeFactory<T> {
  final Identifier _identifier;

  final List<Dependency> _dependencies;
  final Resolve _resolve;

  ObjectsFactory _objectsFactory;

  TransientFactory(this._identifier, this._dependencies, this._resolve) {
    _objectsFactory = ObjectsFactory(_resolve);
  }

  @override
  Either<T, Failure> make() {
    return _objectsFactory.makeByArgs<T>(_identifier.entry,
        _dependencies.map((dependency) => dependency.entry).toList());
  }
}
