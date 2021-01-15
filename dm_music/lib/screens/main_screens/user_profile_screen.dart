import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../song.dart';
import '../../userinfo/user.dart';
import '../add_friends_screen.dart';
import '../change_image_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final DMUser user;
  final bool ownProfile;
  UserProfileScreen(this.user, this.ownProfile);

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  List<Song> songs;

  Future<SignInScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return new SignInScreen();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: !widget.ownProfile ? AppBar() : null,
      backgroundColor: Colors.black,
      bottomNavigationBar: widget.ownProfile ? BottomBar(2, widget.user) : null,
      body: StreamBuilder(
        stream: db
            .collection('users')
            .doc(widget.user.email)
            .collection('songs')
            .snapshots(),
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
          } else {
            return Stack(
              children: [
                BackgroundUserScreen(),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      UserPictureAndUsername(widget: widget),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child:
                                    SectionTitle("Songs", color: Colors.white)),
                            Expanded(
                              flex: 3,
                              child: ListView.separated(
                                itemCount: snapshot.data.docs.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                itemBuilder: (context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      image: DecorationImage(
                                          image: Image.network(snapshot
                                                  .data.docs[index]
                                                  .get("albumCover")
                                                  .toString())
                                              .image,
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.35),
                                              BlendMode.dstATop)),
                                      color: Colors.grey[850],
                                    ),
                                    margin: EdgeInsets.all(10),
                                    width: 160,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(snapshot.data.docs[index].id,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]
                                                  .get("likes")
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Icon(Icons.star,
                                                color: Colors.yellow),
                                            SizedBox(width: 15),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            SectionTitle("Friends", color: Colors.white),
                            SizedBox(height: 5),
                            FriendsList(widget: widget),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class UserPictureAndUsername extends StatelessWidget {
  const UserPictureAndUsername({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfilePicture(widget: widget),
              Text(
                widget.user == null ? "user" : widget.user.username,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserProfileScreen widget;

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(widget.widget.user.profilePicture, height: 170),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ChangeProfileImage(widget.widget.user),
            ),
          )
              .then((value) {
            setState(() {
              print("pop");
            });
          });
        },
      ),
    );
  }
}

class BackgroundUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        painter: CustomPainterProfile(
          Colors.deepPurple[300],
          Colors.lime[800],
          Colors.deepPurple,
          Colors.grey[900],
        ),
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserProfileScreen widget;

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

  final UserProfileScreen widget;

  @override
  _AddFriendIconState createState() => _AddFriendIconState();
}

class _AddFriendIconState extends State<AddFriendIcon> {
  @override
  void initState() {
    super.initState();
  }

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
                .push(
              MaterialPageRoute(
                builder: (context) => AddFriendsScreen(widget.widget.user),
              ),
            )
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
  final UserProfileScreen socialScreen;

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
