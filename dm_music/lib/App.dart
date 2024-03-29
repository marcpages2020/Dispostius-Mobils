import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/main_screens/home_screen.dart';
import 'userinfo/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DmMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    final fireBaseUser = db.collection('users').doc(currentUser.email);

    return MaterialApp(
      title: 'DM Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      home: StreamBuilder(
          stream: fireBaseUser.snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            String username;
            String profilePicture;
            List<dynamic> friends;
            if (snapshot.hasData) {
              username = snapshot.data['username'];
              profilePicture = snapshot.data['profilePicture'];
              friends = snapshot.data['friends'];
            }
            return HomeScreen(
                DMUser(currentUser.email, username, profilePicture, friends));
          }),
    );
  }
}
