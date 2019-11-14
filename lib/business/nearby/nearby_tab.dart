import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab> {
  String title = "万科四季花城";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: 80,
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topButtons(Icons.account_balance, Colors.black, "物业服务",
                  Colors.black, null),
              _topButtons(
                  Icons.live_help, Colors.black, "家电维修", Colors.black, null),
              _topButtons(
                  Icons.android, Colors.black, "保姆月嫂", Colors.black, null),
              _topButtons(
                  Icons.language, Colors.black, "洗车", Colors.black, null),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topButtons(Icons.account_balance, Colors.purple, "便民服务",
                  Colors.black, null),
              _topButtons(
                  Icons.live_help, Colors.blue, "房屋租售", Colors.black, null),
              _topButtons(
                  Icons.android, Colors.red, "各种服务", Colors.black, null),
              _topButtons(
                  Icons.language, Colors.brown, "其他", Colors.black, null),
            ],
          ),
        ),
        Divider(
          height: 2,
          indent: 10,
          endIndent: 10,
          color: Colors.grey[400],
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "推荐",
                style: TextStyle(fontSize: 20),
              ),
              GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
                onTap: null,
              )
            ],
          ),
        )
      ],
    ));
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

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567166278211&di=e53f633ce2be1b59a305259121e0f905&imgtype=0&src=http%3A%2F%2Fpicapi.zhituad.com%2Fphoto%2F67%2F17%2F00FBD.jpg",
      fit: BoxFit.fill,
    ));
  }
}
