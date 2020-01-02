import 'package:Invoker/src/buildable_entry.dart';

abstract class Registrable {
  BuildableEntry bind<R>();
  BuildableEntry bindWithContract<C, R extends C>();
}
