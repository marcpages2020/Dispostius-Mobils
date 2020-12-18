import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      bottomNavigationBar: BottomBar(0),
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ), //You can Replace this with your desired WIDTH and HEIGHT
              painter: CustomPainterMainScreen(
                Colors.deepPurple,
                Colors.grey[900],
                Colors.lime[500],
              ),
            ),
          ),
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
                TextField(
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
