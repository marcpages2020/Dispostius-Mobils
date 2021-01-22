import 'dart:convert';

import '../../screens/songs_screens/lyrics_preview_screen.dart';
import '../../screens/main_screens/home_screen.dart';
import '../../userinfo/user.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../song.dart';

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

  void _loadSuggestions() async {
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
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: SectionTitle(
                    "Search",
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextSearch(_controller, _loadSuggestions),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: suggestions.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return SearchTile(
                        suggestions: suggestions,
                        widget: widget,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile(
      {Key key,
      @required this.suggestions,
      @required this.widget,
      @required this.index})
      : super(key: key);

  final List<Song> suggestions;
  final SearchScreen widget;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        title: Text(
          suggestions[index].title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(suggestions[index].artist,
            style: TextStyle(color: Colors.white)),
        trailing: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(suggestions[index].albumCoverUrl),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  LyricsPreviewScreen(suggestions[index], widget.user),
            ),
          );
        },
      ),
    );
  }
}

class TextSearch extends StatelessWidget {
  final functionToDo;
  final TextEditingController _controller;

  TextSearch(this._controller, this.functionToDo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: TextField(
            onSubmitted: (value) {
              functionToDo();
            },
            controller: _controller,
            decoration: InputDecoration(
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
          ),
        ),
        SizedBox(width: 10),
        Expanded(
            flex: 1,
            child: FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () {
                functionToDo();
              },
            )),
      ],
    );
  }
}
