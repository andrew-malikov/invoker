import 'package:Invoker/src/buildable_entry.dart';
import 'package:Invoker/src/identifier.dart';

abstract class Registrable {
  BuildableEntry bind<R>();
  BuildableEntry bindById(Identifier identifier);
}
