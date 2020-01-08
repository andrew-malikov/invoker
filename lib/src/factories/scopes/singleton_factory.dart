import 'package:dartz/dartz.dart';

import 'package:Invoker/src/producible.dart';
import 'package:Invoker/src/failure.dart';

class SingletonFactory<T> implements Producible<T> {
  final Producible<T> _producible;

  Option<Either<T, Failure>> _cached;

  SingletonFactory(this._producible) {
    _cached = None();
  }

  @override
  Either<T, Failure> make() {
    var resolved;

    _cached.fold(() {
      resolved = _producible.make();

      _cached = Some(resolved);
    }, (exist) => resolved = exist);

    return resolved;
  }
}
