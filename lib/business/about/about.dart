import 'package:flutter/material.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/common/tools.dart';

class About extends StatelessWidget {
  static Map<String, dynamic> commonParamMap = DeviceInfo.info;

  @override
  Widget build(BuildContext context) {
    String version = commonParamMap['version'] ?? '';
    String vc = commonParamMap['vc'] ?? '';
    String homePageUrl = "http://chenings.com";
    return Scaffold(
      appBar: AppBarFactory.getCommon("关于与帮助"),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: ListView(
              children: [
                _getItem("软件版本", "v $version.$vc"),
                _getItem("联系微信", "86161190"),
                _getItem("官方网站", homePageUrl,
                    click: () => Routers.navWebView(homePageUrl)),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => Routers.navigateTo("/pact"),
                    child: Text("用户协议")),
                Container(width: 1, height: 10, color: Colors.black54),
                TextButton(
                    onPressed: () => Routers.navigateTo("/privacy"),
                    child: Text("隐私政策")),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getItem(String title, String content, {VoidCallback? click}) {
    var child = (click == null)
        ? ListTile(
            title: Text(
              title,
              style: Flavors.textStyles.sortTitle,
            ),
            subtitle: Text(content),
          )
        : ListTile(
            trailing: Icon(Icons.keyboard_arrow_right),
            title: Text(
              title,
              style: Flavors.textStyles.sortTitle,
            ),
            subtitle: Text(content),
            onTap: click,
          );
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black26),
      ]),
      child: child,
    );
  }
}
