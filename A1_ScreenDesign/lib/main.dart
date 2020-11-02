import 'package:flutter/material.dart';

import 'package:A1_ScreenDesign/widgets/song_information.dart';
import 'package:A1_ScreenDesign/widgets/top_elements.dart';
import 'package:A1_ScreenDesign/widgets/control_buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen Design',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: _MainScreen(
        song: Song(
            name: "Last Dance",
            author: "Rhye",
            liked: true,
            durationMinutes: 2,
            durationSeconds: 58,
            album: "woman"),
      ),
    );
  }
}

class _MainScreen extends StatelessWidget {
  final Song song;
  _MainScreen({@required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundRect(),
          Row(
            children: [
              Expanded(
                //Left Border Spacing
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 14,
                child: Column(
                  children: [
                    TopElements(),
                    _SongCover(
                      albumName: song.album,
                    ),
                    Spacer(),
                    SongInformation(
                      name: song.name,
                      author: song.author,
                      liked: song.liked,
                    ),
                    SizedBox(height: 60),
                    SliderWidget(durationMinutes: song.durationMinutes, durationSeconds: song.durationSeconds),
                    Spacer(),
                    ControlButtons(),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                //Right Border Spacing
                flex: 1,
                child: Container(),
              )
            ],
          )
          /*
          
          */
        ],
      ),
    );
  }
}

class _SongCover extends StatelessWidget {
  final String albumName;

  _SongCover({@required this.albumName});

  @override
  Widget build(BuildContext context) {
    print(albumName);
    double widthImage = 425.0;
    double heightImage = 450.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(27.0),
      child: Image.asset(
        'assets/images/$albumName.jpg',
        width: widthImage,
        height: heightImage,
        fit: BoxFit.fitHeight,
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
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.75,
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
        ),
      ),
    );
  }
}

class Song {
  String name;
  String author;
  String album;
  bool liked;
  int durationMinutes;
  int durationSeconds;

  Song({
    @required this.name,
    @required this.author,
    @required this.durationMinutes,
        @required this.durationSeconds,
    @required this.album,
    this.liked = false,
  });
}
