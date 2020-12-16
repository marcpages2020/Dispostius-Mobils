import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DmMusic extends StatelessWidget {
  // This widget is the root of your application.
  Widget _buildList(QuerySnapshot snapshot) {
    //final storyDocs = snapshot.docs;
    return MainScreen();

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
    final stories = FirebaseFirestore.instance.collection('stories');
    return MaterialApp(
      title: 'DM Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.lime,
          ),
        ),
      ),
      home: Scaffold(
        body: StreamBuilder(
          stream: stories.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR: ${snapshot.error.toString()}'),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Text('loading...'));
              case ConnectionState.active:
                return _buildList(snapshot.data);
              default:
                return Center(child: Text('Unreachable: done or none!'));
            }
          },
        ),
      ),
    );
  }
}
