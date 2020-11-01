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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Slider(
        value: _sliderValue,
        min: 0,
        max: 100,
        label: _sliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _sliderValue = value;
          });
        },
      ),
    );
  }
}
