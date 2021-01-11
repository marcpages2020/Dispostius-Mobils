class Song {
  String title = "unknown";
  String artist = "unknown";
  String album = "unknown";
  String albumCoverUrl;

  Song(this.title, this.artist, this.album, this.albumCoverUrl);
  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        artist = json['artist']['name'],
        album = json['album']['title'],
        albumCoverUrl = json['album']['cover'];
}