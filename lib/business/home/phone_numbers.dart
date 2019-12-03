import 'package:flutter/material.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class PhoneNumbersPage extends StatefulWidget {
  @override
  PhoneNumbersState createState() => PhoneNumbersState();
}

class PhoneNumbersState extends State<PhoneNumbersPage> {
  @override
  void initState() {
    super.initState();
    AppManager().showToast("长按复制号码");
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
              return _listitem(context, manager.PhoneNumbersList[index]);
            }));
  }

  _listitem(BuildContext context, data) {
    return Consumer<AppManager>(builder: (context, manager, child) {
      if (manager.total == 0) {
        ///loading
        return CupertinoActivityIndicator();
      } else {
        return Container(
            padding: const EdgeInsets.only(top: 8),
            child: ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                data.name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${data.phone}\n${data.des}"),
              onTap: () {
                manager.callPhoneNum(data.phone);
              },
              onLongPress: () {
                manager.copyData(data.phone);
                manager.shareFrame("${data.name}\n${data.phone}");
              },
            ));
      }
    });
  }
}
