
import 'package:flutter/material.dart';

class TopElements extends StatelessWidget {
  const TopElements({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.expand_more,
          color: Colors.black,
        ),
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            'PLAYING NOW',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
        Icon(
          Icons.queue_music,
          color: Colors.white,
        ),
      ],
    );
  }
}