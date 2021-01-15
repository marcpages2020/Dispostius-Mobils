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

  final db = FirebaseFirestore.instance;
  void initList() async {
    StreamBuilder(
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
        print(snapshot.data.docs.length.toString());
        for (var i = 0; i < snapshot.data.docs.length; i++) {
          if (snapshot.data.docs[i].id
              .toString()
              .contains(_friendsController.text)) {
            userList.add(
              DMUser(
                snapshot.data.docs[i].get('email'),
                snapshot.data.docs[i].get('username'),
                snapshot.data.docs[i].get('profilePicture'),
                snapshot.data.docs[i].get('friends'),
              ),
            );
          }
        }
      },
    );

    /*if () {
      //names.add(listUsers[i].id.toString());
    }*/
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
      body: Stack(
        children: [
          BackgroundMainScreen(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextSearch(_friendsController, initList),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: userList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (context, int index) {
                      return ListTile(
                          title: Text(userList[index].username),
                          trailing:
                              Image.network(userList[index].profilePicture),
                          tileColor: Colors.white,
                          onTap: () {
                            /*snapshot.data.docs[index].get('email');*/
                          });
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

/*Stack(
            children: [
              BackgroundMainScreen(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    TextSearch(_friendsController, initList),
                    SizedBox(height: 20),

                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.all(10),
                              itemCount: snapshot.data.docs.lenght,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              itemBuilder: (context, int index) {
                                return ListTile(
                                    title: Text(user["username"]),
                                    trailing:
                                        Image.network(user["profilePicture"]),
                                    tileColor: Colors.white,
                                    onTap: () {
                                      /*user["email"]*/
                                    });
                              }),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );*/
