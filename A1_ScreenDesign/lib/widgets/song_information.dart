import 'dart:ui';

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
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '$author',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
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
