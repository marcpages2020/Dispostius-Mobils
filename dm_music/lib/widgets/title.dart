import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final Color color;

  SectionTitle(this.text, {@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontFamily: "FredokaOne",
          fontStyle: FontStyle.normal,
          shadows: [
            Shadow(
                // bottomLeft
                offset: Offset(-1, -1),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1, -1),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1, 1),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1, 1),
                color: Colors.black),
          ],
        ),
      ),
    );
  }
}
