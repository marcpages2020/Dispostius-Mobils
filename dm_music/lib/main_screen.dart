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
          BackgroundRect(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.7,
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
