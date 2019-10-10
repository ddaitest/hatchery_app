import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hatchery/common/theme.dart';
import 'package:hatchery/common/widget/info_view.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  final String info;

  const TestPage({
    Key key,
    @required this.info,
  }) : super(key: key);

  void test1() {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TestModel(),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Consumer<TestModel>(
              builder: (context, model, child) => Row(
                children: <Widget>[
                  Text("Total price: ${model.total}"),
                  getButtonBig("TEST", onPressed: () {
                    model.add(Boy());
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Boy {
  String name;
  int age;
}

class TestModel extends ChangeNotifier {
  final List<Boy> _boys = [];

  UnmodifiableListView<Boy> get boys => UnmodifiableListView(_boys);

  int get total => _boys.length;

  void add(Boy boy) {
    _boys.add(boy);
    notifyListeners();
  }
}
