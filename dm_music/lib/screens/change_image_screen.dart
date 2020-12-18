import 'package:dm_music/userinfo/image_lists.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horitzontal_image_list.dart';
import 'package:flutter/material.dart';

import '../userinfo/user.dart';
import 'main_screen.dart';

class ChangeProfileImage extends StatefulWidget {
  final DMUser _user;

  ChangeProfileImage(this._user);

  @override
  _ChangeProfileImage createState() => _ChangeProfileImage();
}

class _ChangeProfileImage extends State<ChangeProfileImage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Image",
          style: TextStyle(
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
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
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                widget._user.username,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  //fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              SectionTitle(
                "Spain",
                color: Colors.white,
              ),
              HorizontalImageList(images: spain),
              Text(
                "International",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
              ),
              HorizontalImageList(images: international),
              Text(
                "Videogames",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
              ),
              HorizontalImageList(images: videogames),
              Text(
                "DJ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
              ),
              HorizontalImageList(images: dj),
            ],
          ),
        ],
      ),
    );
  }
}
