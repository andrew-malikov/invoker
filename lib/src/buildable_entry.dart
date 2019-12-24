import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/registrable.dart';

abstract class BuildableEntry {
  void withTag(String name);
  void withContract<C>();
  void withId(Identifier identifier);

  Registrable build();
}