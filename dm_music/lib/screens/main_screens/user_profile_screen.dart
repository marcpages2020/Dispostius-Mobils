import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../song.dart';
import '../../userinfo/user.dart';
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
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProfilePicture(widget: widget),
                                  Text(
                                    widget.user == null
                                        ? "user"
                                        : widget.user.username,
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
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: SectionTitle("Songs",
                                      color: Colors.white)),
                              Expanded(
                                flex: 2,
                                child: ListView.separated(
                                  itemCount: snapshot.data.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(),
                                  itemBuilder: (context, int index) {
                                    return FlatButton(
                                      
                                      child: Container(
                                        
                                      ),
                                      onPressed: () {},
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserProfileScreen widget;

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
          child: Image.network(widget.user.profilePicture, height: 170),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChangeProfileImage(widget.user),
            ),
          );
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

/*
decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          image: DecorationImage(
                                              image: Image.network(snapshot
                                                      .data.docs[index]
                                                      .get("albumCover")
                                                      .toString())
                                                  .image,
                                              fit: BoxFit.fill,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black
                                                      .withOpacity(0.35),
                                                  BlendMode.dstATop)),
                                          color: Colors.grey[850],
                                        ),
                                        margin: EdgeInsets.all(10),
                                        width: 140,
                                        height: 100,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Icon(Icons.star,
                                                    color: Colors.yellow),
                                                SizedBox(width: 15),
                                              ],
                                            ),
                                          ],
                                        ),
*/