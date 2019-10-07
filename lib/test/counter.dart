import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Apple = _Apple with _$Apple;

abstract class _Apple with Store {
  @observable
  int value = 0;

  @action
  void add() {
    value++;
  }
}