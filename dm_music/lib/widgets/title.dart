import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  final String text;
  final Color color;

  Title(this.text, {@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.centerLeft,
    );
  }
}