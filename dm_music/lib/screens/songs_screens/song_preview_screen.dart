import 'package:flutter/material.dart';

import '../../song.dart';

class SongPreviewScreen extends StatefulWidget {
  final Song song;
  final bool isLoggedUserSong;

  SongPreviewScreen(this.song, this.isLoggedUserSong);
  @override
  _SongPreviewScreenState createState() => _SongPreviewScreenState();
}

class _SongPreviewScreenState extends State<SongPreviewScreen>
    with TickerProviderStateMixin {
  bool liked;
  AnimationController animationController;
  @override
  void initState() {
    liked = false;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 30.0,
      upperBound: 35.0,
    );
    super.initState();
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _likeSong() {
    if (!liked) {
      widget.song.likes++;
      liked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.song.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                label: Text(
                  widget.song.likes.toString(),
                ),
                icon: AnimatedBuilder(
                    animation: animationController,
                    builder: (BuildContext context, Widget child) {
                      return Icon(
                        Icons.star,
                        size: 1.0 * animationController.value,
                      );
                    }),
                onPressed: () {
                  if (!widget.isLoggedUserSong) {
                    setState(() {
                      animationController..forward();

                      _likeSong();
                      //animationController..reset();
                    });
                  }
                },
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey[350],
        body: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Text(widget.song.lyrics,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context).pop(widget.song);
      },
    );
  }
}
