import 'package:flutter/material.dart';
import 'package:hatchery/common/widget/info_view.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoView(info: "FirstPage");
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoView(info: "SecondPage");
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoView(info: "ThirdPage");
  }
}
