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

  @override
  int get hashCode {
    var hashCode = entry.hashCode;

    tag.fold(none, (existedTag) => hashCode += existedTag.hashCode);

    return hashCode;
  }

  @override
  bool operator ==(other) {
    if (!other is ImmutableIdentifier) {
      return false;
    }

    var isTagEquals = true;
    tag.fold(() {
      other.tag.fold(none, (existedOtherTag) => isTagEquals = false);
    }, (existedTag) {
      other.tag.fold(() => isTagEquals = false, (existedOtherTag) {
        isTagEquals = existedTag == existedOtherTag;
      });
    });

    return entry.runtimeType == other.entry.runtimeType && isTagEquals;
  }
}
