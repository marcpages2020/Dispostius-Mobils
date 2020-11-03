import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  int counter;
  ControlButtons({
    @required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.shuffle,
          color: Colors.grey,
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.fast_rewind),
            hoverColor: Colors.black,
            color: Colors.white,
            highlightColor: Colors.grey[900],
            splashRadius: 22.0,
            onPressed: () {
              if (counter > 0) counter--;
              debugPrint('counter : $counter');
            },
          ),
        ),
        Container(
          width: 75,
          height: 75,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: IconButton(
              iconSize: (50),
              icon: Icon(Icons.pause),
              hoverColor: Colors.black,
              color: Colors.black,
              highlightColor: Colors.grey[900],
              splashRadius: 43.0,
              onPressed: () {
                /*if (counter > 0) counter--;
                debugPrint('counter : $counter');*/
              },
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.fast_forward),
            hoverColor: Colors.black,
            color: Colors.white,
            focusColor: Colors.grey[900],
            splashRadius: 22.0,
            onPressed: () {
              if (counter >= 0 && counter < 2) counter++;
              debugPrint('counter : $counter');
            },
          ),
        ),
        Icon(
          Icons.repeat,
          color: Colors.grey,
        ),
      ],
    );
  }
}
