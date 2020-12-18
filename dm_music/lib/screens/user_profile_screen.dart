import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horizontal_lists.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../userinfo/user.dart';
import 'change_image_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final DMUser user;

  UserProfileScreen(this.user);

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  Future<SignInScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return new SignInScreen();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(2, widget.user),
      body: Stack(
        children: [
          BackgroundUserScreen(),
          ListView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            children: [
              SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child:
                        Image.network(widget.user.profilePicture, height: 150),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeProfileImage(widget.user),
                      ),
                    );
                  },
                ),
              ),
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
              SizedBox(height: 15),
              SectionTitle("Songs", color: Colors.white),
              HorizontalList(),
              SectionTitle("Albums", color: Colors.white),
              HorizontalList(),
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
              )
            ],
          ),
        ],
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
