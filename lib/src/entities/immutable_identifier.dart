import 'package:Invoker/src/identifier.dart';
import 'package:dartz/dartz.dart';

class ImmutableIdentifier implements Identifier {
  @override
  final Option<Type> contract;

  @override
  final Type entry;

  @override
  final Option<String> tag;

  ImmutableIdentifier(this.entry, this.contract, this.tag);
}
