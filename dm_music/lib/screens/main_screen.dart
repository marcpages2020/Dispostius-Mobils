import 'dart:math';

import 'package:dm_music/screens/user_profile_screen.dart';
import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "DM Music",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          Container(
            width: 80,
            child: FlatButton(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/users_pictures/4.jpg'),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(route.createRoute(
                  scene: UserProfileScreen(),
                  offset: Offset.zero,
                  curves: Curves.easeOut,
                  durationMilli: 500,
                ));
              },
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Theme.of(context).primaryColor, Colors.black]),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(10),
            children: [
              Title("Good Evening", color: Colors.white),
              SizedBox(height: 5),
              Grid(),
              SizedBox(height: 16),
              Title("Recent Songs", color: Colors.white),
              HorizontalList(),
              SizedBox(height: 16),
              Title("Albums", color: Colors.white),
              HorizontalList(),
              SizedBox(height: 16),
              Title("Friends", color: Colors.white),
              SizedBox(height: 2),
              FriendList()
            ],
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
          FriendIcon(),
          FriendIcon(),
          FriendIcon(),
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
          "Name",
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
          color: color,
          fontSize: 22,
          fontFamily: "FredokaOne",
          fontStyle: FontStyle.normal,
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
      children: [
        Row(
          children: [
            SongGridTile(),
            SizedBox(width: 10),
            SongGridTile(),
          ],
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
          color: Colors.grey[900],
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/note.png',
                height: 200,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Song",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
