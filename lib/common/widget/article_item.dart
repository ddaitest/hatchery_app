import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/beans.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final Function onTap;

  ArticleItem(this.article, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: Flavors.sizes.articleItemHeight,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            _getLeft(),
            _getThumbnail(),
          ],
        ),
      ),
      onTap: () => onTap,
    );
  }

  _getLeft() => Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitle(),
          _getSummary(),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          _getBottom(),
        ],
      ));

//  _getTop() => Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Expanded(
//              flex: 1,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  _getTitle(),
//                  _getSummary(),
//                  _getBottom(),
//                ],
//              )),
//          _getThumbnail(),
//        ],
//      );

  _getBottom() => Container(
        child: Text("${article.updateTime}", style: Flavors.styles.secondary),
        color: Colors.white,
      );

  _getTitle() => Container(
        child: Text(article.title, style: Flavors.styles.title1),
        color: Colors.white,
      );

  _getSummary() => Container(
        child:
            Text(article.contents, maxLines: 2, style: Flavors.styles.content),
        color: Colors.white,
      );

  _getThumbnail() {
    return CachedNetworkImage(
      imageUrl: article.thumbnail,
      fit: BoxFit.fill,
      height: Flavors.sizes.articleThumbnail,
      width: Flavors.sizes.articleThumbnail,
    );
  }

  _getLine() {
    return Container(
      height: 1,
      color: Colors.black26,
    );
  }
}
