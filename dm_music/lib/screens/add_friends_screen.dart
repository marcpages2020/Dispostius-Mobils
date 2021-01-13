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
  var listUsers;
  List<DMUser> userList = [];
  @override
  void initState() {
    _friendsController = TextEditingController();
    user =
        FirebaseFirestore.instance.collection('users').doc(widget.user.email);
    listUsers = FirebaseFirestore.instance.collection('users');
    super.initState();
  }

  @override
  void dispose() {
    _friendsController.dispose();
    super.dispose();
  }

  void initList() async {
    listUsers = FirebaseFirestore.instance.collection('users').snapshots();
    List<String> names = [];
    for (int i = 0; i < listUsers.lenght; i++) {
      if (listUsers[i].id.toString().contains(_friendsController.text)) {
        names.add(listUsers[i].id.toString());
      }
    }
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
                    onPressed: () => initList(),
                  ),
                ),
                ListView.separated(
                  itemCount: userList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 6),
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    if (index != 0) {
                      return ListTile(
                        tileColor: Colors.blueGrey[800],
                        title: Text(
                          userList[index].username,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Image.network(
                          userList[index].profilePicture,
                        ),
                        onTap: () {
                          bool exist = false;
                          for (int i = 0; i < widget.user.friends.length; i++) {
                            if (_friendsController == widget.user.friends[i])
                              exist = true;
                            else
                              exist = false;
                          }
                          if (!exist) {
                            widget.user.friends.add(_friendsController.text);
                            user.set(
                              DMUser.setUser(
                                      widget.user.email,
                                      widget.user.friends,
                                      widget.user.profilePicture)
                                  .toFirestore(),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
