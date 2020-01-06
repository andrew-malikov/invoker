import 'package:Invoker/invoker.dart';

import 'package:test/test.dart';

void main() {
  test('Container.resolve<Warrior>() return Warrior with one Weapon', () {
    final container = ContainerFactory()
        .empty()
        .bindWithContract<Weapon, Katana>()
        .asTransient()
        .bindWithContract<Warrior, Ninja>()
        .asTransient();

    expect(container.resolve<Warrior>().isLeft(), equals(true));
  });

  test('Container.resolve<Warrior>() return Failure', () {
    final container = ContainerFactory()
        .empty()
        .bindWithContract<Warrior, Ninja>()
        .asTransient();

    expect(container.resolve<Warrior>().isRight(), equals(true));
  });
}

abstract class Warrior {
  Warrior(Weapon weapon);
}

class Ninja extends Warrior {
  Ninja(Weapon weapon) : super(weapon);
}

abstract class Weapon {}

class Katana implements Weapon {}

class Nunchucks implements Weapon {}
