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
          BackgroundRect(
            widhtPercentage: 0.9,
            heightPercentage: 0.75,
          ),
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/users_pictures/4.jpg',
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "User",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        // Grid(),
                        SizedBox(height: 16),
                        Text(
                          "Songs",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HorizontalList(),
                        SizedBox(height: 10),
                        Text(
                          "Albums",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HorizontalList(),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
              Container(
                color: Colors.white,
                child: FlatButton(
                  onPressed: () {
                    _signOut();
                  },
                  child: Text("Sign Out"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
