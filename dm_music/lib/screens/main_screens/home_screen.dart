import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/songs_screens/edit_song_screen.dart';
import '../../userinfo/image_lists.dart';
import '../../userinfo/user.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/custom_painters.dart';
import '../../widgets/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../song.dart';

class HomeScreen extends StatefulWidget {
  final DMUser user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _editSong(String oldSong, Song newSong) {
    final db = FirebaseFirestore.instance;
    final songs =
        db.collection('users').doc(widget.user.email).collection('songs');
    final firestoreSong = songs.doc(oldSong);

    if (newSong.title != oldSong) {
      firestoreSong.delete();
      songs.doc(newSong.title).set(newSong.toFirestore());
    } else {
      firestoreSong.set(newSong.toFirestore());
    }
  }

  Widget _buildDeleteSongDialog(BuildContext context, String songName) {
    return new AlertDialog(
      title: Text('Do you want to delete this song?'),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            _deleteSong(songName);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  _deleteSong(String songId) {
    final db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(widget.user.email)
        .collection('songs')
        .doc(songId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBar(1, widget.user),
      backgroundColor: Colors.black,
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
            }
            return Stack(
              children: [
                BackgroundMainScreen(),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SectionTitle(
                          "Your Songs",
                          color: Colors.white,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: ListView.separated(
                        padding: EdgeInsets.all(10),
                        itemCount: snapshot.data.docs.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemBuilder: (context, int index) {
                          return Card(
                            color: Colors.grey[850],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ListTile(
                              title: Text(
                                snapshot.data.docs[index].id,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data.docs[index].get('artist'),
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot
                                        .data.docs[index]
                                        .get('albumCover')),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditSongScreen(
                                            Song.fromNewFirestore(
                                                snapshot.data.docs[index]),
                                            widget.user)))
                                    .then(
                                  (changedSong) {
                                    setState(() {
                                      if (changedSong != null) {
                                        _editSong(snapshot.data.docs[index].id,
                                            changedSong);
                                      }
                                    });
                                  },
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildDeleteSongDialog(context,
                                            snapshot.data.docs[index].id));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

class BackgroundMainScreen extends StatelessWidget {
  const BackgroundMainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        painter: CustomPainterMainScreen(
          Colors.deepPurple,
          Colors.grey[900],
          Colors.lime[800],
        ),
      ),
    );
  }
}

String getRandomImage() {
  List<List> genresList = [spain, international, videogames, dj];
  int randomGenre = new Random().nextInt(4);
  List genre = genresList[randomGenre];
  int randomSinger = new Random().nextInt(genre.length);

  return genre[randomSinger];
}
