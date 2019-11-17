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
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _getTop(),
            Divider(),
          ],
        ),
      ),
      onTap: () => onTap,
    );
  }

  _getTop() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTitle(),
                  _getSummary(),
                  _getBottom(),
                ],
              )),
          _getThumbnail(),
        ],
      );

  _getBottom() => Container(
        child: Text("${article.publishOn}", style: Flavors.styles.articleTitle),
        color: Colors.white,
      );

  _getTitle() => Container(
        child: Text(article.title, style: Flavors.styles.articleTitle),
        color: Colors.white,
      );

  _getSummary() => Container(
        child: Text(article.summary,
            maxLines: 2, style: Flavors.styles.articleSummary),
        color: Colors.white,
      );

  _getThumbnail() {
    return CachedNetworkImage(
      imageUrl: article.thumbnail,
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
