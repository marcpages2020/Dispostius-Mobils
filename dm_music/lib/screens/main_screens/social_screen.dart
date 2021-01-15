import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/add_friends_screen.dart';
import 'package:dm_music/screens/main_screens/home_screen.dart';
import 'package:dm_music/screens/main_screens/user_profile_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatefulWidget {
  final DMUser user;

  SocialScreen(this.user);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(3, widget.user),
      body: Stack(
        children: [
          BackgroundMainScreen(),
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SectionTitle("Friends", color: Colors.white),
              SizedBox(height: 10),
              FriendsList(widget: widget),
            ],
          ),
        ],
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SocialScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.user.friends.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.user.friends.length) {
            return AddFriendIcon(widget: widget);
          } else {
            return FriendIcon(socialScreen: widget, index: index);
          }
        },
      ),
    );
  }
}

class AddFriendIcon extends StatefulWidget {
  const AddFriendIcon({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SocialScreen widget;

  @override
  _AddFriendIconState createState() => _AddFriendIconState();
}

class _AddFriendIconState extends State<AddFriendIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Colors.black,
              child: Icon(
                Icons.add_circle_outline_rounded,
                size: 60,
                color: Colors.limeAccent[700],
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddFriendsScreen(widget.widget.user),
            ))
                .then((value) {
              setState(() {});
            });
          },
        ),
        SizedBox(height: 1),
        Text(
          "Add Friend",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class FriendIcon extends StatefulWidget {
  final SocialScreen socialScreen;

  const FriendIcon({
    Key key,
    @required this.socialScreen,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  _FriendIconState createState() => _FriendIconState();
}

class _FriendIconState extends State<FriendIcon> {
  DMUser friendUser;
  var friend;
  @override
  void initState() {
    initUser();
    super.initState();
  }

  void initUser() async {
    final db = FirebaseFirestore.instance;
    friend = await db
        .collection('users')
        .doc(widget.socialScreen.user.friends[widget.index])
        .get();

    setState(() {
      friendUser = DMUser(widget.socialScreen.user.friends[widget.index],
          friend["username"], friend["profilePicture"], friend["friends"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
                friendUser == null
                    ? "https://pbs.twimg.com/profile_images/1306654479601864715/5rJogQzq_400x400.jpg"
                    : friendUser.profilePicture,
                height: 60),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfileScreen(friendUser, false);
                },
              ),
            ).then((value) {
              setState(() {});
            });
          },
        ),
        SizedBox(height: 1),
        Text(
          friendUser == null ? "user" : friendUser.username,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
