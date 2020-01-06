import 'package:dartz/dartz.dart';

import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/failure.dart';
import 'package:Invoker/src/factories/objects_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/scope_factory.dart';
import 'package:Invoker/src/resolvable.dart';

class TransientFactory implements ScopeFactory {
  final Identifier _identifier;

  final List<Dependency> _dependencies;
  final Resolve _resolve;

  ObjectsFactory _objectsFactory;

  TransientFactory(this._identifier, this._dependencies, this._resolve) {
    _objectsFactory = ObjectsFactory(_resolve);
  }

  @override
  Either<dynamic, Failure> make() {
    return _objectsFactory.makeByArgs(_identifier.entry,
        _dependencies.map((dependency) => dependency.entry).toList());
  }
}
