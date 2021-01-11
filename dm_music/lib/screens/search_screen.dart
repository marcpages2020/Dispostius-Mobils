import 'dart:convert';

import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final DMUser user;

  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String lyrics;
  bool loading;
  TextEditingController _controller;

  @override
  void initState() {
    lyrics = "loading";
    loading = true;

    _loadLyrics();
    super.initState();
  }

  void _loadLyrics() async {
    final response = await http
        .get("https://api.lyrics.ovh/v1/Coldplay/Adventure of a Lifetime");
    final tmplyrics = jsonDecode(response.body);
    setState(() {
      lyrics = tmplyrics['lyrics'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
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
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                TextSearch(controller: _controller),
                Expanded(
                  child: Container(
                      child: SingleChildScrollView(child: Text(lyrics, style: TextStyle(fontSize: 16),))),
                )
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
          borderSide: BorderSide(color: Colors.black),
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
