import 'package:dartz/dartz.dart';
import 'package:sprintf/sprintf.dart';

import 'package:Invoker/src/failure.dart';

class ContractFailure extends Failure {
  static final String _mismatchTemplate =
      "Can't match contract of %0s with registered dependencies";
  static final String _mismatchByTagTemplate =
      "Can't match contract of %0s by tag %1s with registered dependencies";
  static final String _multipleImplementationsTemplate =
      'Found multiple contract implementations of %0s';

  final Type contract;
  final Option<String> tag;

  ContractFailure(this.contract, String message,
      [Option<Failure> related, Option<String> tag])
      : tag = tag ?? None(),
        super(message, related);

  ContractFailure.Mismatch(Type contract, [Option<Failure> related])
      : this(contract, sprintf(_mismatchTemplate, [contract]), related);

  ContractFailure.MismatchByTag(Type contract, String tag,
      [Option<Failure> related])
      : this(contract, sprintf(_mismatchByTagTemplate, [contract, tag]), None(),
            Some(tag));

  ContractFailure.MulpipleImplementations(Type contract,
      [Option<Failure> related])
      : this(contract, sprintf(_multipleImplementationsTemplate, [contract]),
            related);
}
