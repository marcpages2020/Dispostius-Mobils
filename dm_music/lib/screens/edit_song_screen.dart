import 'package:dm_music/song.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

class EditSongScreen extends StatefulWidget {
  final DMUser user;
  final Song song;

  EditSongScreen(this.song, this.user);
  @override
  _EditSongScreenState createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {
  TextEditingController _titleController;
  TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _titleController.text = widget.song.title;
    _contentController = TextEditingController();
    _contentController.text = widget.song.lyrics;
    super.initState();
  }

  void _editSong() {
    widget.song.title = _titleController.text;
    widget.song.lyrics = _contentController.text;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _titleController,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _editSong();
              Navigator.of(context).pop(widget.song);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
            child: Container(
              color: Colors.lime,
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.white,
              child: SingleChildScrollView(
                  child: TextField(
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )),
            ),
          )
        ],
      ),
    );
  }
}
