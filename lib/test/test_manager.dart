import 'package:mobx/mobx.dart';

class ABC {
  Action increment;
  final _value = Observable(0);

  int get value => _value.value;

  set value(int newValue) => _value.value = newValue;

  ABC() {
    increment = Action(_add);
  }

  void _add() {
    _value.value++;
  }
}
