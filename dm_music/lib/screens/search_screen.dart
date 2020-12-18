import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
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
                          color: Colors.black,
                        ),
                        Shadow(
                          // bottomRight
                          offset: Offset(1, -1),
                          color: Colors.black,
                        ),
                        Shadow(
                          // topRight
                          offset: Offset(1, 1),
                          color: Colors.black,
                        ),
                        Shadow(
                          // topLeft
                          offset: Offset(-1, 1),
                          color: Colors.black,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                TextSearch(controller: _controller),
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
