import 'dart:convert';

import 'package:dm_music/screens/lyrics_preview_screen.dart';
import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../song.dart';

class SearchScreen extends StatefulWidget {
  final DMUser user;
  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Song> suggestions;
  bool loading;
  TextEditingController _controller;

  @override
  void initState() {
    suggestions = [];
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadSuggestions() async {
    final response =
        await http.get("https://api.lyrics.ovh/suggest/${_controller.text}");
    final json = jsonDecode(response.body);
    List<Song> _suggestions = [];

    for (var jsonSuggestion in json['data']) {
      _suggestions.add(Song.fromJson(jsonSuggestion));
    }

    setState(() {
      suggestions = _suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(0, widget.user),
      body: Stack(
        children: [
          BackgroundMainScreen(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                TextSearch(controller: _controller),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: suggestions.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: Colors.blueGrey[800],
                        title: Text(
                          suggestions[index].title,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(suggestions[index].artist,
                            style: TextStyle(color: Colors.white)),
                        trailing: Image.network(
                          suggestions[index].albumCoverUrl,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LyricsPreviewScreen(
                                  suggestions[index], widget.user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.grey[900],
                      child: Icon(Icons.search),
                      onPressed: () {
                        _loadSuggestions();
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextSearch extends StatelessWidget {
  const TextSearch({
    Key key,
    @required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
