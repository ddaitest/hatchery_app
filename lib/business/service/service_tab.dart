import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServiceTab extends StatefulWidget {
  @override
  ServiceTabState createState() => ServiceTabState();
}

class ServiceTabState extends State<ServiceTab> {
  var subjects;
  List<ServiceListInfo> subjectLists = [];

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  _getListData() async {
    subjects = await AppManager().queryServiceData();
    setState(() {
      subjectLists = subjects;
      print('LC -> ${subjectLists[0].picSmall}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppManager(),
      child: _ServicePage(context),
    );
  }

  _ServicePage(BuildContext context) {
    return Consumer<AppManager>(
        builder: (context, manager, child) => _pageTopView(manager));
  }

//  _getBody(manager) {
//    return ListView(
//      children: <Widget>[_pageTopView(manager)],
//    );
//  }

  _pageTopView(manager) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topButtons(Icons.account_balance, Colors.black,
                  manager.ServiceTopMap["0"], Colors.black, null),
              _topButtons(Icons.live_help, Colors.black,
                  manager.ServiceTopMap["1"], Colors.black, null),
              _topButtons(Icons.android, Colors.black,
                  manager.ServiceTopMap["2"], Colors.black, null),
              _topButtons(Icons.language, Colors.black,
                  manager.ServiceTopMap["3"], Colors.black, null),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topButtons(Icons.account_balance, Colors.black,
                  manager.ServiceTopMap["4"], Colors.black, null),
              _topButtons(Icons.live_help, Colors.black,
                  manager.ServiceTopMap["5"], Colors.black, null),
              _topButtons(Icons.android, Colors.black,
                  manager.ServiceTopMap["6"], Colors.black, null),
              _topButtons(Icons.language, Colors.black,
                  manager.ServiceTopMap["7"], Colors.black, null),
            ],
          ),
        ),
        Container(
          height: 10,
          color: Color.fromARGB(255, 234, 233, 234),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "| ",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                    Text(
                      "推荐",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
                onTap: null,
              ),
            ],
          ),
        ),
        getListViewContainer(),
      ],
    );
  }

  getListViewContainer() {
    if (subjectLists.length == 0) {
      ///loading
      return CupertinoActivityIndicator();
    }
    return Expanded(
        child: ListView.builder(
            itemCount: subjectLists.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getItemContainerView(subjectLists[index]),

                  ///下面的灰色分割线
                  Divider(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                ],
              );
            }));
  }

  getItemContainerView(var subject) {
    var imgUrl = subject.picSmall;
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          getImage(imgUrl),
          Container(
            child: getInfoView(subject),
            width: MediaQuery.of(context).size.width - 116,
          ),
        ],
      ),
    );
  }

  getInfoView(var subject) {
    return Container(
      height: 90,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          getTitleView(subject),
        ],
      ),
    );
  }

  getTitleView(subject) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              subject.title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  getImage(var imgUrl) {
    return Container(
      child: CachedNetworkImage(
        height: 90,
        width: 90,
        imageUrl: imgUrl,
        fit: BoxFit.fill,
      ),
      margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      width: 100.0,
    );
  }

  _topButtons(IconName, IconColor, String name, nameColor, tapValue) {
    return MaterialButton(
      onPressed: tapValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconName,
            size: 35,
            color: IconColor,
          ),
          Text(
            name,
            style: TextStyle(color: nameColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
