import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/song.dart';
import 'package:dm_music/userinfo/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LyricsPreviewScreen extends StatefulWidget {
  final Song song;
  final DMUser user;

  LyricsPreviewScreen(this.song, this.user);

  @override
  _LyricsPreviewScreenState createState() => _LyricsPreviewScreenState();
}

class _LyricsPreviewScreenState extends State<LyricsPreviewScreen> {
  String lyrics;
  var user;
  @override
  void initState() {
    lyrics = "loading";
    _loadLyrics();
    super.initState();
    user =
        FirebaseFirestore.instance.collection('users').doc(widget.user.email);
  }

  void _loadLyrics() async {
    final response = await http.get(
        'https://api.lyrics.ovh/v1/${widget.song.artist}/${widget.song.title}');
    final json = jsonDecode(response.body);

    setState(() {
      lyrics = json['lyrics'];

      if (lyrics == "") {
        lyrics = "No lyrics available";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
            user.collection('songs').doc(widget.song.title).set(Song(
                    widget.song.title,
                    widget.song.artist,
                    widget.song.album,
                    widget.song.albumCoverUrl,
                    lyrics)
                .toFirestore());
          }),
        ],
      ),
      backgroundColor: Colors.purple,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Text(
                widget.song.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                widget.song.artist,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Text(
                      lyrics,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
