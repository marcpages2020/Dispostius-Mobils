import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/search_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class AddFriendsScreen extends StatefulWidget {
  final DMUser user;

  AddFriendsScreen(this.user);
  @override
  _AddFriendsScreenState createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  TextEditingController _friendsController;
  var user;

  @override
  void initState() {
    _friendsController = TextEditingController();
    user =
        FirebaseFirestore.instance.collection('users').doc(widget.user.email);
    super.initState();
  }

  @override
  void dispose() {
    _friendsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Friends"),
      ),
      body: Stack(
        children: [
          BackgroundMainScreen(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Stack(
              children: [
                TextSearch(
                  controller: _friendsController,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey[900],
                    child: Icon(Icons.search),
                    onPressed: () {
                      bool exist = false;
                      for (int i = 0; i < widget.user.friends.length; i++) {
                        if (widget.user.friends[i] == _friendsController.text)
                          exist = true;
                        else
                          exist = false;
                      }
                      if (!exist) {
                        widget.user.friends.add(_friendsController.text);
                        user.set(
                          DMUser.setFriend(widget.user.friends).toFirestore(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
