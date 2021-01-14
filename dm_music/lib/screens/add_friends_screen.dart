import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_screens/search_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

import 'main_screens/home_screen.dart';

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
  List<String> names = [];

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

  void initList() async {
    if (listUsers.id.toString().contains(_friendsController.text)) {
      //names.add(listUsers[i].id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Friends"),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: db.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              BackgroundMainScreen(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    TextSearch(
                      _friendsController,
                      initList,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(10),
                        itemCount:
                            4 /*snapshot.data.docs.getDocuments().lenght*/,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemBuilder: (context, int index) {
                          return ListTile(
                            title: Text(snapshot.data.docs[index].id),
                            trailing: Image.network(snapshot.data.docs[index]
                                .get('profilePicture')),
                            tileColor: Colors.white,
                            onTap: () {
                              bool exist = false;
                              for (int i = 0;
                                  i < widget.user.friends.length;
                                  i++) {
                                if (_friendsController ==
                                    widget.user.friends[i])
                                  exist = true;
                                else
                                  exist = false;
                              }
                              if (!exist) {
                                widget.user.friends
                                    .add(_friendsController.text);
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
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey[900],
                        child: Icon(Icons.search),
                        onPressed: () => initList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
