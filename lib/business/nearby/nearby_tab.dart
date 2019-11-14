import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab> {
  String title = "万科四季花城";
  Color mainColor = Colors.orange[500];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: mainColor,
            title: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(title),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Icon(
                Icons.settings_overscan,
                size: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                child: Icon(
                  Icons.search,
                  size: 25,
                ),
              )
            ]),
        body: Column(
          children: <Widget>[
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: mainColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _topButtons(Icons.account_balance, Colors.white, "生活缴费",
                      Colors.black, null),
                  _topButtons(Icons.live_help, Colors.white, "访客通行",
                      Colors.black, null),
                  _topButtons(
                      Icons.android, Colors.white, "物业报事", Colors.black, null),
                  _topButtons(
                      Icons.language, Colors.white, "代收包裹", Colors.black, null),
                ],
              ),
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _topButtons(Icons.account_balance, Colors.purple, "生活缴费",
                      Colors.black, null),
                  _topButtons(
                      Icons.live_help, Colors.blue, "访客通行", Colors.black, null),
                  _topButtons(
                      Icons.android, Colors.red, "物业报事", Colors.black, null),
                  _topButtons(
                      Icons.language, Colors.brown, "代收包裹", Colors.black, null),
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
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width - 20,
              height: 140.0,
              child: Swiper(
                itemBuilder: _swiperBuilder,
                itemCount: 3,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Colors.white,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                autoplay: true,
                onTap: null,
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "福利铺",
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
