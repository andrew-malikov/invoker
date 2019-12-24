import 'package:Invoker/src/dependency.dart';
import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class ManagableScope implements Producible {
  final List<Dependency> dependencies;
  final Resolvable resolvable;

  ManagableScope(this.resolvable, this.dependencies);
}
