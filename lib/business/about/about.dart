import 'package:flutter/material.dart';
import 'package:hatchery/common/widget/app_bar.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory.getCommon("关于与帮助"),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
