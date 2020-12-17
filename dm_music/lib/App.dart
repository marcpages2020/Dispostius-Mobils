import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DmMusic extends StatelessWidget {
  // This widget is the root of your application.
  Widget _setMainPage(QuerySnapshot snapshot) {
    final users = snapshot.docs;

    for (var user in users) {
      if(user.id == "marcpages2020")
      {
        
        return MainScreen(DMUser(user));
      }
    }

    /*
    return ListView.builder(
      itemCount: storyDocs.length,
      itemBuilder: (context, int index) {
        final story = storyDocs[index];
        return ListTile(
          title: Text(story['title']),
          subtitle: Text(story['URL']),
        );
      },
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance.collection('users');
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
      home: Scaffold(
        body: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR: ${snapshot.error.toString()}'),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return _setMainPage(snapshot.data);
              default:
                return Center(child: Text('Unreachable: done or none!'));
            }
          },
        ),
      ),
    );
  }
}
