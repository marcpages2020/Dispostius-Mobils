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
    userList = [];

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

    setState(() {
      //userList = tmpList;
    });
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
                      return CustomTile(
                        userList: userList,
                        widget: widget,
                        user: user,
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
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key key,
    @required this.userList,
    @required this.widget,
    @required this.user,
    @required this.index,
  }) : super(key: key);

  final List<DMUser> userList;
  final AddFriendsScreen widget;

  final user;
  final int index;

  Widget _buildPopupDialog(BuildContext context, bool exist) {
    if (!exist) {
      return new AlertDialog(
        title: Text('Friend Added to your Friends'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Close',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    } else {
      return new AlertDialog(
        title: Text('This friends is already in you list'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Close',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }
  }

  void checkyourfriends(BuildContext context) {
    bool exist = false;
    for (int i = 0; i < widget.user.friends.length; i++) {
      if (userList[index].email == widget.user.friends[i])
        exist = true;
      else
        exist = false;
    }
    if (!exist) {
      widget.user.friends.add(userList[index].email);
      user.set(
        DMUser.setUser(widget.user.username, widget.user.friends,
                widget.user.profilePicture)
            .toFirestore(),
      );
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
          userList[index].username,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          userList[index].email,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(userList[index].profilePicture),
            ),
          ),
        ),
        onTap: () {
          checkyourfriends(context);
        },
      ),
    );
  }
}
