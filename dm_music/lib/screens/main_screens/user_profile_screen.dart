import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/sign_in-log_in/sign_in_screen.dart';
import 'package:dm_music/screens/songs_screens/song_preview_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../song.dart';
import '../../userinfo/user.dart';
import '../add_friends_screen.dart';
import '../change_image_screen.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatefulWidget {
  final DMUser userToShow;
  DMUser loggedUser;
  final bool ownProfile;
  UserProfileScreen(this.userToShow, this.loggedUser, this.ownProfile);

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  final List<Song> songs = [];

  @override
  void initState() {
    super.initState();
  }

  void _deleteFriend(DMUser friendToDelete) async {
    List<dynamic> friends = [];

    for (var i = 0; i < widget.loggedUser.friends.length; i++) {
      if (widget.loggedUser.friends[i] != friendToDelete.email) {
        friends.add(widget.loggedUser.friends[i]);
      }
    }

    widget.loggedUser.friends = friends;

    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.loggedUser.email);

    user.set(DMUser.setUser(widget.loggedUser.username,
            widget.loggedUser.friends, widget.loggedUser.profilePicture)
        .toFirestore());

    widget.loggedUser.friends = friends;
  }

  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: !widget.ownProfile
          ? AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: Colors.grey[850],
                      child: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _deleteFriend(widget.userToShow);
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          : null,
      backgroundColor: Colors.black,
      bottomNavigationBar:
          widget.ownProfile ? BottomBar(2, widget.loggedUser) : null,
      body: StreamBuilder(
        stream: db
            .collection('users')
            .doc(widget.userToShow.email)
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
                              child: SectionTitle(
                                "Songs",
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListView.separated(
                                itemCount: snapshot.data.docs.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                itemBuilder: (context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SongPreviewScreen(
                                            Song.fromNewFirestore(
                                                snapshot.data.docs[index]),
                                            widget.ownProfile,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.userToShow.email)
                                              .collection('songs')
                                              .doc(snapshot.data.docs[index].id)
                                              .update(value.toFirestore());
                                        }
                                      });
                                    },
                                    child: Container(
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
                            SectionTitle(
                              "Friends",
                              color: Colors.white,
                              alignment: Alignment.centerLeft,
                            ),
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

class UserPictureAndUsername extends StatefulWidget {
  const UserPictureAndUsername({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserProfileScreen widget;

  @override
  _UserPictureAndUsernameState createState() => _UserPictureAndUsernameState();
}

class _UserPictureAndUsernameState extends State<UserPictureAndUsername> {
  Future<SignInScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();

    return new SignInScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfilePicture(widget: widget.widget),
                  Text(
                    widget.widget.userToShow == null
                        ? "user"
                        : widget.widget.userToShow.username,
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
          Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: widget.widget.ownProfile
                    ? Container(
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          child: Icon(Icons.logout),
                          onPressed: () {
                            setState(() {
                              _signOut();
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      )
                    : null,
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
          child: Image.network(widget.widget.userToShow.profilePicture,
              height: 170),
        ),
        onPressed: () {
          if (widget.widget.ownProfile) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) =>
                    ChangeProfileImage(widget.widget.userToShow),
              ),
            )
                .then((value) {
              setState(() {});
            });
          }
        },
      ),
    );
  }
}

class BackgroundUserScreen extends StatefulWidget {
  @override
  _BackgroundUserScreenState createState() => _BackgroundUserScreenState();
}

class _BackgroundUserScreenState extends State<BackgroundUserScreen> {
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
    @required this.widget,
  });

  final UserProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.ownProfile
            ? widget.userToShow.friends.length + 1
            : widget.userToShow.friends.length,
        itemBuilder: (BuildContext context, int index) {
          if (widget.ownProfile && index == widget.userToShow.friends.length) {
            return AddFriendIcon(userProfileScreen: widget, friendsList: this);
          } else {
            return FriendIcon(userProfileScreen: widget, index: index);
          }
        },
      ),
    );
  }
}

class AddFriendIcon extends StatefulWidget {
  final FriendsList friendsList;
  const AddFriendIcon({
    @required this.userProfileScreen,
    this.friendsList,
  });

  final UserProfileScreen userProfileScreen;

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
                builder: (context) =>
                    AddFriendsScreen(widget.userProfileScreen.userToShow),
              ),
            )
                .then((value) {
              setState(() {
                widget.userProfileScreen.loggedUser.friends = value;
                widget.friendsList.build(context);
              });
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
  final UserProfileScreen userProfileScreen;

  const FriendIcon({
    Key key,
    @required this.userProfileScreen,
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
        .doc(widget.userProfileScreen.userToShow.friends[widget.index])
        .get();

    setState(() {
      friendUser = DMUser(
          widget.userProfileScreen.userToShow.friends[widget.index],
          friend["username"],
          friend["profilePicture"],
          friend["friends"]);
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
                  return UserProfileScreen(
                      friendUser, widget.userProfileScreen.loggedUser, false);
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
