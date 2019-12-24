import 'package:Invoker/src/dependency.dart';

class ImmutableDependency implements Dependency {
  @override
  final Type entry;

  ImmutableDependency(this.entry);
}
