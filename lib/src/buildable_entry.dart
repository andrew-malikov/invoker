import 'package:Invoker/src/container.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/managable_scope.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class BuildableEntry {
  void withTag(String tag);
  void withContract<C>();

  Container asSingleton();
  Container asTransient();
}

typedef BuildScope = ManagableScope Function(Resolve);
typedef Registrate = Container Function(Identifier, BuildScope);
