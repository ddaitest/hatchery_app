import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hatchery/manager/main_manager.dart';
import 'package:scoped_model/scoped_model.dart';

import 'business/splash/splash.dart';
import 'configs.dart';
import 'manager/ad_manager.dart';
import 'test/a_model.dart';
import 'test/counter.dart';
import 'test/test_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppManager>(
        model: AppManager(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: ScopedModel<AdManager>(
              model: AdManager(),
              child: SplashPage(),
            )));
  }
}

final apple = Apple();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TestModel>(
      model: TestModel(),
      child: _test(),
    );
  }

  _test() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ScopedModelDescendant<AppManager>(
              builder: (context, child, model) => Text("app=${model.m}"),
            ),
            ScopedModelDescendant<AdManager>(
              builder: (context, child, model) => Text("ad=${model.ad}"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScopedModel.of<AppManager>(context).apptest();
          ScopedModel.of<AdManager>(context).test();
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getMobx() {
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) => Text(
                '${apple.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: apple.add,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
