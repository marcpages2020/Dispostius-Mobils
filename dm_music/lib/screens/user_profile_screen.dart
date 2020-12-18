import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../userinfo/user.dart';
import 'change_image_screen.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen();

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  Future<SignInScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return new SignInScreen();
  }

  Widget build(BuildContext context) {
    final DMUser user = Provider.of<DMUser>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(2),
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context)
                      .size
                      .height), //You can Replace this with your desired WIDTH and HEIGHT
              painter: CustomPainterProfile(
                Colors.deepPurple[300],
                Colors.lime[500],
                Colors.deepPurple,
                Colors.grey[900],
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.asset(
                      'assets/users_pictures/4.jpg',
                      height: 150,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeProfileImage(user),
                    ));
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                user.username,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  //fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                "Songs",
                color: Colors.white,
              ),
              HorizontalList(),
              SectionTitle(
                "Albums",
                color: Colors.white,
              ),
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
