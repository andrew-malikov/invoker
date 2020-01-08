import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/factories/scopes/provided_factory.dart';
import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class BuildableEntry<T> {
  void withTag(String tag);
  void withFactory(Produce<T> produce);

  DependencyContainer asSingleton();
  DependencyContainer asTransient();
}

typedef BuildScope = Producible Function(Resolve);
typedef Registrate = DependencyContainer Function(Identifier, BuildScope);
