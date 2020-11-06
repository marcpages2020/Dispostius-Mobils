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
        SongControlButton(icon: Icons.shuffle, color: Colors.grey,),
        SongControlButton(icon: Icons.fast_rewind, color: Colors.white),
        Container(
          width: 75,
          height: 75,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: IconButton(
              iconSize: (40),
              icon: Icon(Icons.pause),
              hoverColor: Colors.black,
              color: Colors.black,
              highlightColor: Colors.grey[900],
              splashRadius: 42.0,
              onPressed: () {},
            ),
          ),
        ),
        SongControlButton(icon: Icons.fast_forward, color: Colors.white),
        SongControlButton(icon: Icons.repeat, color: Colors.grey),
      ],
    );
  }
}

class SongControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  const SongControlButton({@required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      child: IconButton(
        icon: Icon(icon),
        hoverColor: Colors.black,
        color: color,
        focusColor: Colors.grey[900],
        splashRadius: 22.0,
        onPressed: () {},
      ),
    );
  }
}
