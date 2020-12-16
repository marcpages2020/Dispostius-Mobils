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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/note.png'),
          ),
          Container(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/note.png'),
          ),
          Container(width: 20),
            ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/note.png'),
          ),
          Container(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/note.png'),
          ),
        ],
      ),
    );
  }
}
