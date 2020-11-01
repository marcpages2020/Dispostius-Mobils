import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key key,
  }) : super(key: key);

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
        Icon(
          Icons.fast_rewind,
          color: Colors.white,
        ),
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
          ),
          child: Icon(
            Icons.pause,
            size: 50,
          ),
        ),
        Icon(
          Icons.fast_forward,
          color: Colors.white,
        ),
        Icon(
          Icons.repeat,
          color: Colors.grey,
        ),
      ],
    );
  }
}
