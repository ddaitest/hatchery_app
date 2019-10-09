import 'package:scoped_model/scoped_model.dart';

class AppManager extends Model {
  int _m = 0;

  int get m => _m;

  void apptest() {
    _m++;
    notifyListeners();
  }

//  AppManager() {
//    print("MainManager init $hashCode");
//  }

  static final AppManager _instance = AppManager._create();

  factory AppManager() => _instance;

  AppManager._create() {
    print("MainManager init $hashCode");
  }
}
