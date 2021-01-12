import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  String title = "unknown";
  String artist = "unknown";
  String album = "unknown";
  String albumCoverUrl;
  String lyrics;

  Song(this.title, this.artist, this.album, this.albumCoverUrl);
  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        artist = json['artist']['name'],
        album = json['album']['title'],
        albumCoverUrl = json['album']['cover'];

  Song.fromNewFirestore(QueryDocumentSnapshot doc) {
    this.title = doc['title'];
    this.lyrics = doc['lyrics'];
    this.artist = doc['artist'];
    this.album = doc['album'];
    this.albumCoverUrl = doc['albumCover'];
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'lyrics': lyrics,
        'artist': artist,
        'album': album,
        'albumCover': albumCoverUrl,
      };
}
