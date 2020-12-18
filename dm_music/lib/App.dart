import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/userinfo/user.dart';
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
            builder:
            (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              String username;
              if (snapshot.hasData) {
                username = snapshot.data['username'];
              }
              return MainScreen(DMUser(currentUser.email, username));
            };
          }),
    );
  }
}
