import 'dart:html';

import 'package:flutter/material.dart';

class SongInformation extends StatelessWidget {
  final String name;
  final String author;
  final bool liked;
  SongInformation(
      {@required this.name, @required this.author, @required this.liked});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$author',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
        Container(
          child: Icon(
            //Icons.favorite_border,
            liked ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
