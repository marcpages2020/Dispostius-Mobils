import 'dart:math';

import 'package:dm_music/userinfo/image_lists.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horizontal_lists.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final DMUser user;

  MainScreen(this.user);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBar(1, widget.user),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundMainScreen(),
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

class BackgroundMainScreen extends StatelessWidget {
  const BackgroundMainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        painter: CustomPainterMainScreen(
          Colors.deepPurple,
          Colors.grey[850],
          Colors.lime[800],
        ),
      ),
    );
  }
}

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GridRow(),
        SizedBox(height: 5),
        GridRow(),
        SizedBox(height: 5),
        GridRow(),
      ],
    );
  }
}

class GridRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SongGridTile(),
        SizedBox(width: 2),
        SongGridTile(),
      ],
    );
  }
}

class SongGridTile extends StatelessWidget {
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
            child: Image.network(
              getRandomImage(),
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

String getRandomImage() {
  List<List> genresList = [spain, international, videogames, dj];
  int randomGenre = new Random().nextInt(4);
  List genre = genresList[randomGenre];
  int randomSinger = new Random().nextInt(genre.length);

  return genre[randomSinger];
}
