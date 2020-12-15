import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.all(2),
            width: 100.0,
            color: Colors.red,
          ),
          Container(width: 20),
          Container(
            width: 100.0,
            color: Colors.blue,
          ),
          Container(width: 20),
          Container(
            width: 100.0,
            color: Colors.green,
          ),
          Container(width: 20),
          Container(
            width: 100.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}