import 'package:dartz/dartz.dart';

import 'package:Invoker/src/failure.dart';
import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/resolvable.dart';

typedef Produce<T> = T Function(Resolvable resolvable);

class ProvidedFactory<T> implements Producible<T> {
  final Resolvable _resolvable;
  final Produce<T> _produce;

  ProvidedFactory(this._produce, this._resolvable);

  @override
  Either<T, Failure> make() {
    return Left(_produce(_resolvable));
  }
}
