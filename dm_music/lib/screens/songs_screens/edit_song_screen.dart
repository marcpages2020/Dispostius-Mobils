import 'package:dm_music/screens/songs_screens/search_image.dart';
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
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 18),
            cursorColor: Colors.white,
            controller: _titleController,
          ),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                child: Image.network(widget.song.albumCoverUrl),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeImage(widget.user, widget.song),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _editSong();
                  Navigator.of(context).pop(widget.song);
                },
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 10,
            child: Container(),
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
