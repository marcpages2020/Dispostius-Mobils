import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatefulWidget {
  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(3),
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
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
