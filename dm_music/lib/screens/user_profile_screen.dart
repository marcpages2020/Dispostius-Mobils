import 'package:dm_music/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../userinfo/user.dart';

class UserProfileScreen extends StatefulWidget {
  DMUser _user;

  UserProfileScreen(this._user);

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
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Theme.of(context).primaryColor, Colors.black]),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    'assets/users_pictures/4.jpg',
                    height: 150,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget._user.username,
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
              Text(
                "Songs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
              ),
              HorizontalList(),
              Text(
                "Albums",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                ),
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
