import 'dart:math';

import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../userinfo/user.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final DMUser user = Provider.of<DMUser>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBar(1),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context)
                      .size
                      .height), //You can Replace this with your desired WIDTH and HEIGHT
              painter: CustomPainterMainScreen(
                Colors.deepPurple,
                Colors.grey[850],
                Colors.lime[500],
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 40),
              SectionTitle("Good Evening", color: Colors.white),
              SizedBox(height: 10),
              Grid(),
              SizedBox(height: 30),
              SectionTitle("Recent Songs", color: Colors.white),
              HorizontalList(),
              SectionTitle("Albums", color: Colors.white),
              HorizontalList(),
            ],
          ),
        ],
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  final List<dynamic> friends;
  FriendList(this.friends);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: friends.length,
          itemBuilder: (BuildContext context, int index) {
            return FriendIcon(friends[index]);
          }),
    );
  }
}

class FriendIcon extends StatelessWidget {
  String name;

  FriendIcon(this.name);

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int user = random.nextInt(4) + 1;

    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/users_pictures/$user.jpg',
              height: 60,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 1),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        )
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final Color color;

  SectionTitle(this.text, {@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontFamily: "FredokaOne",
          fontStyle: FontStyle.normal,
          shadows: [
            Shadow(
                // bottomLeft
                offset: Offset(-1, -1),
                color: Colors.black),
            Shadow(
                // bottomRight
                offset: Offset(1, -1),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(1, 1),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-1, 1),
                color: Colors.black),
          ],
        ),
      ),
      alignment: Alignment.centerLeft,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SongGridTile(), SizedBox(width: 2), SongGridTile()],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SongGridTile(), SizedBox(width: 2), SongGridTile()],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SongGridTile(), SizedBox(width: 2), SongGridTile()],
        ),
      ],
    );
  }
}

class SongGridTile extends StatelessWidget {
  const SongGridTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.grey[900],
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/note.png',
              height: MediaQuery.of(context).size.height * 0.075,
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.27,
            child: Text(
              "Blinding Lights",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "FredokaOne",
                fontStyle: FontStyle.normal,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      onPressed: () {},
    );
  }
}
