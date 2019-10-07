import 'package:scoped_model/scoped_model.dart';

class AdManager extends Model {
  int _ad = 0;

  int get ad => _ad;

  void test() {
    print("TEST $hashCode");
    _ad++;
    notifyListeners();
  }
}
