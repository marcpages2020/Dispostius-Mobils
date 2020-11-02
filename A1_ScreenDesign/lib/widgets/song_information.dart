import 'dart:html';

import 'package:flutter/material.dart';

class SongInformation extends StatelessWidget {
  const SongInformation({
    Key key,
  }) : super(key: key);

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
              'Last Dance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rhys',
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
            Icons.favorite,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}

class SliderWidget extends StatefulWidget {
  @override
  SliderState createState() => SliderState();
}

class SliderState extends State<SliderWidget> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 10.0,
              disabledThumbRadius: 5.0,
            ),
          ),
          child: Slider(
            value: _sliderValue,
            min: 0,
            max: 178,
            inactiveColor: Colors.grey[850],
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),
        Row(
          children: [
            Container(
              child: Text(
                '${parseToMinutesSeconds(_sliderValue)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.only(left: 10),
            ),
            Container(
              child: Text(
                '2:58',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
      ],
    );
  }
}

String parseToMinutesSeconds(double ms) {
  String data;
  Duration duration = Duration(milliseconds: ms.toInt() * 1000);

  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds) - (minutes * 60);

  data = minutes.toString() + ":";
  if (seconds <= 9) data += "0";

  data += seconds.toString();
  return data;
}
