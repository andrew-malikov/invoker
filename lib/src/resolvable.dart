import 'package:optional/optional.dart';

abstract class Resolvable {
  Optional<C> resolve<C>();
  Optional<C> resolveByTag<C>(String name);
}
