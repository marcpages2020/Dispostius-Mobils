import 'dart:ffi';

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DM Music"),
        actions: [
          Icon(
            Icons.circle,
            size: 50,
            color: Colors.lime,
          )
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundRect(
            widhtPercentage: 0.8,
            heightPercentage: 0.7,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      width: 100.0,
                      color: Colors.red,
                    ),
                    Container(width: 20),
                    Container(
                      width: 100.0,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 100.0,
                      color: Colors.green,
                    ),
                    Container(
                      width: 100.0,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

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
