import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab> {
  var subjects = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => NearbyManager(),
      child: _bodyContainer(context),
    );
  }

  _bodyContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [_bannerContainer(context)]),
    );
  }

  _bannerContainer(BuildContext context) {
    return Consumer<NearbyManager>(
        builder: (context, manager, child) => Container(
              margin: EdgeInsets.only(top: 10),
              height: 120,
              child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image:
                          CachedNetworkImageProvider(manager.bannerList[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
                itemHeight: 120,
                itemCount: manager.bannerTotal,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(),
                onTap: (index) {
                  try {
//            launchcaller(infos[index].action);
                  } catch (id) {}
                },
              ),
            ));
  }
}
