import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/userinfo/image_lists.dart';
import 'package:dm_music/widgets/horizontal_lists.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:flutter/material.dart';

import '../userinfo/user.dart';
import 'main_screens/home_screen.dart';

class ChangeProfileImage extends StatefulWidget {
  final DMUser user;

  ChangeProfileImage(this.user);

  @override
  _ChangeProfileImage createState() => _ChangeProfileImage();
}

class _ChangeProfileImage extends State<ChangeProfileImage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SectionTitle("Change Image", color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundMainScreen(),
          HoritzontalListOfImages(widget: widget),
        ],
      ),
    );
  }
}

class HoritzontalListOfImages extends StatelessWidget {
  const HoritzontalListOfImages({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ChangeProfileImage widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
      children: [
        SizedBox(height: 40),
        UsernameTitle(widget: widget),
        SizedBox(height: 15),
        SectionTitle("Spain", color: Colors.white),
        HorizontalImageList(images: spain, widget: widget),
        SectionTitle("International", color: Colors.white),
        HorizontalImageList(images: international, widget: widget),
        SectionTitle("Videogames", color: Colors.white),
        HorizontalImageList(images: videogames, widget: widget),
        SectionTitle("DJ", color: Colors.white),
        HorizontalImageList(images: dj, widget: widget),
      ],
    );
  }
}

class UsernameTitle extends StatelessWidget {
  const UsernameTitle({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ChangeProfileImage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SectionTitle(
          widget.user == null ? "user" : widget.user.username,
          color: Colors.white,
        ),
      ],
    );
  }
}
