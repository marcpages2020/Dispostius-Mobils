import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_screens/search_screen.dart';
import '../userinfo/user.dart';
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
  var firebaseUser;
  List<DMUser> userList = [];
  List<String> names = [];

  @override
  void initState() {
    _friendsController = TextEditingController();
    firebaseUser =
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
    userList = [];
    // ignore: unused_local_variable
    final users = await db.collection('users').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (user) {
                if (user.id.toString().contains(_friendsController.text)) {
                  userList.add(
                    DMUser(
                      user.id,
                      user['username'],
                      user['profilePicture'],
                      user['friends'],
                    ),
                  );
                }
              },
            )
          },
        );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                        return CustomTile(
                          userList: userList,
                          friendsScreen: widget,
                          firebaseUser: firebaseUser,
                          index: index,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () {
        print("pop");
        Navigator.of(context).pop(widget.user.friends);
      },
    );
  }
}

class CustomTile extends StatefulWidget {
  const CustomTile({
    Key key,
    @required this.userList,
    @required this.friendsScreen,
    @required this.firebaseUser,
    @required this.index,
  }) : super(key: key);

  final List<DMUser> userList;
  final AddFriendsScreen friendsScreen;

  final firebaseUser;
  final int index;

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  Widget _buildPopupDialog(BuildContext context, bool exist) {
    if (!exist) {
      return AlertDialog(
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 3,
            color: Colors.lime[800],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text(
          'Friend Added to your Friends',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Close',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 3,
            color: Colors.lime[800],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text(
          'This friends is already in you list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              }),
        ],
      );
    }
  }

  void checkYourFriends(BuildContext context) {
    bool exist = false;
    for (int i = 0; i < widget.friendsScreen.user.friends.length; i++) {
      if (widget.userList[widget.index].email ==
          widget.friendsScreen.user.friends[i]) {
        exist = true;
        break;
      } else
        exist = false;
    }

    if (!exist) {
      widget.friendsScreen.user.friends
          .add(widget.userList[widget.index].email);
      widget.firebaseUser.set(
        DMUser.setUser(
                widget.friendsScreen.user.username,
                widget.friendsScreen.user.friends,
                widget.friendsScreen.user.profilePicture)
            .toFirestore(),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context, exist));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context, exist));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        title: Text(
          widget.userList[widget.index].username,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.userList[widget.index].email,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.userList[widget.index].profilePicture),
            ),
          ),
        ),
        onTap: () {
          checkYourFriends(context);
        },
      ),
    );
  }
}
