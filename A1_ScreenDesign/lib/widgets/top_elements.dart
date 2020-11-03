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
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            icon: Icon(Icons.expand_more),
            hoverColor: Colors.black,
            color: Colors.black,
            focusColor: Colors.black,
            splashRadius: 22.0,
            onPressed: () {
              //if (counter >= 0 && counter < 2) counter++;
              //debugPrint('counter : $counter');
            },
          ),
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
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.queue_music),
            hoverColor: Colors.black,
            color: Colors.white,
            focusColor: Colors.black,
            splashRadius: 22.0,
            onPressed: () {
              //if (counter >= 0 && counter < 2) counter++;
              //debugPrint('counter : $counter');
            },
          ),
        ),
      ],
    );
  }
}
