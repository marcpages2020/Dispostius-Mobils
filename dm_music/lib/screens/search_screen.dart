import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Theme.of(context).primaryColor, Colors.grey[900]]),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
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
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(height: 10),
                FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*


*/
