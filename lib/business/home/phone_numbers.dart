import 'package:flutter/material.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PhoneNumbersPage extends StatefulWidget {
  @override
  PhoneNumbersState createState() => PhoneNumbersState();
}

class PhoneNumbersState extends State<PhoneNumbersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppManager(),
      child: _ScaffoldView(),
    );
  }

  _ScaffoldView() {
    return Consumer<AppManager>(
      builder: (context, manager, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "服务热线",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: _bodyView(manager),
      ),
    );
  }

  _bodyView(manager) {
    return Consumer<AppManager>(
        builder: (context, manager, child) => ListView.builder(
            shrinkWrap: true,
            itemCount: manager.total,
            itemBuilder: (BuildContext context, int index) {
              return _listitem(manager);
            }));
  }

  _listitem(manager) {
    return ListTile(
      title: Text("#####"),
      subtitle: Text("#####"),
    );
  }
}
