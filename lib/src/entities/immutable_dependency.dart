import 'package:Invoker/src/dependency.dart';

class ImmutableDependency implements Dependency {
  @override
  final Type entry;

  ImmutableDependency(this.entry);

  @override
  int get hashCode => entry.hashCode;

  @override
  bool operator ==(other) {
    if (!other is ImmutableDependency) {
      return false;
    }

    return entry == other.entry;
  }
}
