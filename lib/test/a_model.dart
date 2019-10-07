import 'package:scoped_model/scoped_model.dart';

mixin AModel implements Model {
  int _aaa = 0;

  int get aaa => _aaa;

  void increment() {
    // First, increment the counter
    _aaa++;

    // Then notify all the listeners.
    notifyListeners();
  }
}
