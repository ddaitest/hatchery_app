import 'package:flutter/material.dart';

class TestSilverTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
//        SliverAppBar(
//          title: Text('SliverAppBar'),
//          backgroundColor: Colors.green,
//          expandedHeight: 200.0,
//          flexibleSpace: FlexibleSpaceBar(
//            background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
//          ),
//        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(child: Text("TEST $index"), height: 150.0);
            },
            childCount: 3,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
              Container(color: Colors.pink),
            ],
          ),
        ),
      ],
    );
  }

  _getList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(child: Text("TEST $index"), height: 150.0);
        },
        childCount: 3,
      ),
    );
  }
}
