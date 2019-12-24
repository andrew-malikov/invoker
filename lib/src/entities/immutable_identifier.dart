import 'package:Invoker/src/identifier.dart';
import 'package:optional/optional_internal.dart';

class ImmutableIdentifier implements Identifier {
  @override
  final Optional<Type> contract;

  @override
  final Type entry;

  @override
  final Optional<String> tag;

  ImmutableIdentifier(this.contract, this.entry, this.tag);
}
