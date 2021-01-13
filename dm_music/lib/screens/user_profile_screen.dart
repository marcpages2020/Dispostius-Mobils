import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horizontal_lists.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../song.dart';
import '../userinfo/user.dart';
import 'change_image_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final DMUser user;

  UserProfileScreen(this.user);

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
    print(widget.user.username);
    super.initState();
  }

  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(2, widget.user),
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
                  Column(
                    children: [
                      SizedBox(height: 50),
                      ProfilePicture(widget: widget),
                      SizedBox(height: 10),
                      Text(
                        widget.user == null ? "user" : widget.user.username,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //SizedBox(height: 15),
                      SectionTitle("Songs", color: Colors.white),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(10),
                          itemCount: snapshot.data.docs.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          itemBuilder: (context, int index) {
                            return Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data.docs[index].id,
                                  ),
                                  Row(
                                    children: [
                                      Text("1"),
                                      Icon(Icons.star, color: Colors.yellow,),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
          borderRadius: BorderRadius.circular(70),
          child: Image.network(widget.user.profilePicture, height: 150),
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

                
                
                
                
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      _signOut();
                    },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontFamily: "FredokaOne",
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
*/
