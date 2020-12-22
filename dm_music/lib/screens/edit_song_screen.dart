import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

class EditSongScreen extends StatefulWidget {
  DMUser user;
  String song_id;
  EditSongScreen(this.song_id, this.user);
  @override
  _EditSongScreenState createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {
  TextEditingController title;
  TextEditingController content;

@override
  void initState() {
    title = TextEditingController();
    content = TextEditingController();
    super.initState();
  }

@override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final song = db
        .collection('users')
        .doc(widget.user.email)
        .collection('songs')
        .doc(widget.song_id)
        .snapshots();
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 30, child: Container(color: Colors.lime,),),
        TextField(
          controller: title,
        ),
        TextField(
          controller: content,
          maxLines: 10,
        )
      ],
    ));
  }
}
