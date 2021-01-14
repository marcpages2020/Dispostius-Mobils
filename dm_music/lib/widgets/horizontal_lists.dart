import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/change_image_screen.dart';
import 'package:dm_music/screens/main_screens/home_screen.dart';
import 'package:dm_music/song.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  List<Song> songs;

  HorizontalList(this.songs);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        padding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              FlatButton(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(getRandomImage(), height: 100),
                ),
                onPressed: () {},
              ),
              SizedBox(height: 4),
              Container(
                width: 120,
                height: 30,
                child: Text(
                  "Blinding Lights",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HorizontalImageList extends StatelessWidget {
  const HorizontalImageList({
    Key key,
    @required List<String> images,
    @required this.widget,
  })  : _images = images,
        super(key: key);
  final ChangeProfileImage widget;
  final List<String> _images;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length,
        padding: EdgeInsets.only(top: 6, bottom: 6),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              FlatButton(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(_images[index], height: 100),
                ),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.user.email)
                      .set(DMUser.setUser(widget.user.username,
                              widget.user.friends, _images[index])
                          .toFirestore());

                  widget.user.profilePicture = _images[index];

                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 4),
            ],
          );
        },
      ),
    );
  }
}
