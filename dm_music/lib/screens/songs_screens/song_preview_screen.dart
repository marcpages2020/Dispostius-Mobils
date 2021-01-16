import 'package:flutter/material.dart';

import '../../song.dart';

class SongPreviewScreen extends StatefulWidget {
  final Song song;
  final bool isLoggedUserSong;

  SongPreviewScreen(this.song, this.isLoggedUserSong);
  @override
  _SongPreviewScreenState createState() => _SongPreviewScreenState();
}

class _SongPreviewScreenState extends State<SongPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        actions: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              if (!widget.isLoggedUserSong) {
                widget.song.likes++;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.song.likes.toString(),
                ),
                Icon(Icons.star),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.lime[800],
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Text(widget.song.lyrics,
                      style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
