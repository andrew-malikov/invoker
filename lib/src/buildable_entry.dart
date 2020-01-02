import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/scope_factory.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class BuildableEntry {
  void withTag(String tag);

  DependencyContainer asSingleton();
  DependencyContainer asTransient();
}

typedef BuildScope = ScopeFactory Function(Resolve);
typedef Registrate = DependencyContainer Function(Identifier, BuildScope);
