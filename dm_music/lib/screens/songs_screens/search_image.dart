import 'dart:io';

import 'package:dm_music/screens/main_screens/home_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../song.dart';

class ChangeImage extends StatefulWidget {
  final DMUser user;
  Song song;
  ChangeImage(this.user, this.song);

  @override
  _ChangeImageState createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  @override
  void initState() {
    isNetworkImage();
    super.initState();
  }

  void isNetworkImage() {
    if (widget.song.albumCoverUrl.contains("https"))
      fromNetwork = true;
    else
      fromNetwork = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool fromNetwork;
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundMainScreen(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: SectionTitle(
                    "Change Cover of Song",
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: _image != null
                            ? FileImage(_image)
                            : NetworkImage(widget.song.albumCoverUrl),
                        radius: 150,
                      ),
                      SizedBox(height: 20),
                      FloatingActionButton.extended(
                        heroTag: "btn1",
                        backgroundColor: Colors.grey[800],
                        label: Text(
                          "Import From Gallery",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                      ),
                      SizedBox(height: 20),
                      FloatingActionButton.extended(
                        heroTag: "btn2",
                        backgroundColor: Colors.grey[800],
                        label: Text(
                          "Take a Picture",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                      ),
                    ],
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
