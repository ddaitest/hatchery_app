import 'package:flutter/material.dart';

import '../../configs.dart';

class FeedbackListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          COMMUNITY_NAME,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepPurple,
        height: 200,
      ),
    );
  }
}
