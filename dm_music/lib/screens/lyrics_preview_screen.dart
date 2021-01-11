import 'dart:convert';

import 'package:dm_music/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LyricsPreviewScreen extends StatefulWidget {
  final Song song;

  LyricsPreviewScreen(this.song);

  @override
  _LyricsPreviewScreenState createState() => _LyricsPreviewScreenState();
}

class _LyricsPreviewScreenState extends State<LyricsPreviewScreen> {
  String lyrics;

  @override
  void initState() {
    lyrics = "loading";
    _loadLyrics();
    super.initState();
  }

  void _loadLyrics() async {
    print(
        'https://api.lyrics.ovh/v1/${widget.song.artist}/${widget.song.title}');
    final response = await http.get(
        'https://api.lyrics.ovh/v1/${widget.song.artist}/${widget.song.title}');
    final json = jsonDecode(response.body);

    setState(() {
      lyrics = json['lyrics'];

      if(lyrics == ""){
        lyrics = "No lyrics available";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                widget.song.artist,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
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
