import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/factories/instance_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/managable_scope.dart';
import 'package:Invoker/src/resolvable.dart';

import 'package:dartz/dartz.dart';

class TransientFactory implements ManagableScope {
  final Identifier _identifier;

  final List<Dependency> _dependencies;
  final Resolve _resolve;

  InstanceFactory _instanceFactory;

  TransientFactory(this._identifier, this._dependencies, this._resolve) {
    _instanceFactory = InstanceFactory(_resolve);
  }

  @override
  Option make() {
    return _instanceFactory.makeByArgs(
        _identifier.entry, _dependencies.map((dependency) => dependency.entry));
  }
}
