import 'package:flutter/material.dart';
import 'package:hatchery/business/about/res.dart';
import 'package:hatchery/common/widget/app_bar.dart';

class PactPage extends StatelessWidget {
  final int type;

  PactPage(this.type);

  @override
  Widget build(BuildContext context) {
    String title = type == 1 ? privacyTitle : pactTitle;
    String content = type == 1 ? privacyContent : pactContent;
    return Scaffold(
      appBar: AppBarFactory.getCommon(title),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(content),
          ],
        ),
      ),
    );
  }
}
