import 'package:dm_music/sign_in_flow/screens/sign_in_screen.dart';
import 'package:dm_music/widgets/background_rect.dart';
import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Future<SignInScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();

    return new SignInScreen();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.asset(
                  'assets/users_pictures/4.jpg',
                  height: 150,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "User",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold),
              ),
              HorizontalList(),
                Text(
                "Albums",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              HorizontalList(),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: FlatButton(
                  onPressed: () {
                    _signOut();
                  },
                  child: Text("Sign Out"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
