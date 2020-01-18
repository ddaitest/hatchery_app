import 'package:flutter/material.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/configs.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashManager(context),
      child: _splashPage(context),
    );
  }

  _splashPage(BuildContext context) {
    return Consumer<SplashManager>(builder: (context, manager, child) {
      if (manager.agreementData) {
        if (manager.total != 0) {
          return Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    constraints: BoxConstraints.expand(),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "社区名称",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                decoration: TextDecoration.none),
                          ),
                          Icon(
                            Icons.videogame_asset,
                            size: 50,
                          ),
                        ],
                      ),
                    )),
                GestureDetector(
                  onTap: () => manager.clickAD(context),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 150,
                    child: CachedNetworkImage(
                      imageUrl: manager.adLists[0].imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  width: 75.0,
                  top: 50.0,
                  right: 20.0,
                  //控件透明度 0.0完全透明，1.0完全不透明
                  child: Opacity(
                    opacity: 0.4,
                    child: FlatButton(
                      color: Colors.black,
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.black,
                      child:
                          Consumer<SplashManager>(builder: (cdt, manager, cd) {
                        return Text("跳过 ${manager.countdownTime}");
                      }),
                      onPressed: () => manager.skip(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
              width: double.infinity,
              height: double.infinity,
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "$COMMUNITY_NAME社区",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          decoration: TextDecoration.none),
                    ),
                    Icon(
                      Icons.videogame_asset,
                      size: 50,
                    ),
                  ],
                ),
              ));
        }
      } else {
        return Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "images/welcome.png",
                  fit: BoxFit.cover,
                ),
              ),
              AlertDialog(
                title: Text(
                  "服务条款和用户协议提示",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                          "欢迎使用本软件！\n在您使用本软件前，请您认真阅读并同意用户协议和隐私政策，以了解我们的服务内容和我们在收集和使用您相关个人信息时的处理规则。我们将严格按照用户协议和隐私政策为您提供服务，保护您的个人信息。"),
                      Container(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => manager.agreementUrl(context),
                        child: Text("《用户协议》",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                      ),
                      Container(
                        height: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "确定",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () => manager.agree(context),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              manager.exitApp();
                            },
                            child: Text(
                              "不同意并退出App",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
