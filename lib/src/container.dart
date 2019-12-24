import 'package:Invoker/src/identifier.dart';
import 'package:Invoker/src/managable_scope.dart';
import 'package:Invoker/src/registrable.dart';
import 'package:Invoker/src/resolvable.dart';

abstract class Container implements Registrable, Resolvable {
  final Map<Identifier, ManagableScope> scopes;

  Container(this.scopes);
}
