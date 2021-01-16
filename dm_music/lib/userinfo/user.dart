import 'package:cloud_firestore/cloud_firestore.dart';

class DMUser {
  String username;
  String email;
  String profilePicture;
  List<dynamic> friends = [];

  //DMUser(this.username, this.email);
  DMUser(this.email, this.username, this.profilePicture, this.friends);

  DMUser.setUser(this.username, this.friends, this.profilePicture);

  DMUser.fromFirestore(QueryDocumentSnapshot doc) {
    this.email = doc.id;
    this.username = doc['username'];
    this.profilePicture = doc['profilePicture'];
    this.friends = doc['friends'];
  }

  DMUser.fromFirestoreSnapshot(DocumentSnapshot doc) {
    this.email = doc.id;
    this.username = doc['username'];
    this.profilePicture = doc['profilePicture'];
    this.friends = doc['friends'];
  }

  Map<String, dynamic> toFirestore() => {
        'username': username,
        'friends': friends,
        'profilePicture': profilePicture,
      };
}
