import 'package:flutter/material.dart';

class BackgroundRect extends StatelessWidget {
  const BackgroundRect({
    Key key,
    @required double widhtPercentage,
    @required double heightPercentage,
  })  : _widhtPercentage = widhtPercentage,
        _heightPercentage = heightPercentage,
        super(key: key);

  final double _widhtPercentage;
  final double _heightPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * _widhtPercentage,
      height: MediaQuery.of(context).size.height * _heightPercentage,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.lime,
              Colors.lightGreen[300],
            ],
          ),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
        ),
      ),
    );
  }
}