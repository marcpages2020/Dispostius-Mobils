import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 20,
                    child: Column(
                      children: [
                        Title("Good Evening", color: Colors.black),
                        SizedBox(
                          height: 5,
                        ),
                        Grid(),
                        SizedBox(height: 16),
                        Title("Recent Songs", color: Colors.black),
                        HorizontalList(),
                        SizedBox(height: 16),
                        Title("Albums", color: Colors.black),
                        HorizontalList(),
                        SizedBox(height: 16),
                        Title("Friends", color: Colors.white),
                        SizedBox(height: 2),
                        FriendList()
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      height: 120,
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
          Container(width: 20),
          Container(
            width: 100.0,
            color: Colors.green,
          ),
          Container(width: 20),
          Container(
            width: 100.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  const FriendList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FriendIcon(),
          SizedBox(
            width: 15,
          ),
          FriendIcon(),
          SizedBox(
            width: 15,
          ),
          FriendIcon(),
          SizedBox(
            width: 15,
          ),
          FriendIcon(),
          SizedBox(
            width: 15,
          ),
          FriendIcon(),
        ],
      ),
    );
  }
}

class FriendIcon extends StatelessWidget {
  const FriendIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 40,
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 36,
      ),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [SongGridTile(), SizedBox(width: 10), SongGridTile()],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [SongGridTile(), SizedBox(width: 10), SongGridTile()],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [SongGridTile(), SizedBox(width: 10), SongGridTile()],
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final String text;
  final Color color;

  Title(this.text, {@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            color: color, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.centerLeft,
    );
  }
}

class SongGridTile extends StatelessWidget {
  const SongGridTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Song",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        ),
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
