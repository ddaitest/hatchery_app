import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TestManager(),
      child: TestView(),
    );
  }
}

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TestManager manager = Provider.of<TestManager>(context, listen: false);
    return Container(
      child: Column(
        children: <Widget>[
          //Consumer 会监听全部，只要manager有notify 就会刷新
          Consumer<TestManager>(
            builder: (context, manager, child) => _showX(manager.x),
          ),
          RaisedButton(child: Text("ADD X"), onPressed: () => manager.testX()),
          //Selector 只监听，selector 条件过滤的改变。
          Selector<TestManager, int>(
            builder: (BuildContext context, int value, Widget? child) =>
                _showY(value),
            selector: (BuildContext context, TestManager manager) {
              return manager.y;
            },
          ),
          RaisedButton(child: Text("ADD Y"), onPressed: () => manager.testY()),
        ],
      ),
    );
  }

  _showX(x) {
    print("SHOW X $x");
    return Text("X=$x");
  }

  _showY(y) {
    print("SHOW Y $y");
    return Text("Y=$y");
  }
}

class TestManager extends ChangeNotifier {
  int _x = 0;
  int _y = 0;

  int get y => _y;

  int get x => _x;

  void testX() {
    _x++;
    notifyListeners();
  }

  void testY() {
    _y++;
    notifyListeners();
  }
}
