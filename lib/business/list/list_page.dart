import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  String serviceId;

  ListPage(this.serviceId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.amber,
        height: 300,
      ),
    );
  }
}
