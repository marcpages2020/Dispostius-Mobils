import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  String title = "unknown";
  String artist = "unknown";
  String album = "unknown";
  String albumCoverUrl;
  String lyrics;
  int likes = 0;

  Song(this.title, this.artist, this.album, this.albumCoverUrl, this.lyrics, this.likes);
  
  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        artist = json['artist']['name'],
        album = json['album']['title'],
        albumCoverUrl =
            json['album']['cover'].replaceFirst("http://", "https://");

  Song.fromNewFirestore(QueryDocumentSnapshot doc) {
    this.title = doc['title'];
    this.lyrics = doc['lyrics'];
    this.artist = doc['artist'];
    this.album = doc['album'];
    this.albumCoverUrl = doc['albumCover'];
    this.likes = doc['likes'];
  }

  Map<String, dynamic> toFirestore() => {
        'title': title,
        'lyrics': lyrics,
        'artist': artist,
        'album': album,
        'albumCover': albumCoverUrl,
        'likes' : likes,
      };
}
