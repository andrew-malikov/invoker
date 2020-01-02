import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class ScopeFactory implements Producible {
  final Identifier _identifier;

  final List<Dependency> _dependencies;
  final Resolve _resolve;

  ScopeFactory(this._identifier, this._resolve, this._dependencies);
}
