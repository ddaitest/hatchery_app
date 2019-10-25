
import 'package:flutter/foundation.dart';

class AdManager extends ChangeNotifier {
  int _ad = 0;

  int get ad => _ad;

  void test() {
    print("TEST $hashCode");
    _ad++;
    notifyListeners();
  }
}
