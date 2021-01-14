import 'package:cloud_firestore/cloud_firestore.dart';

class DMUser {
  String username;
  String email;
  String profilePicture;
  List<dynamic> friends = [];

  //DMUser(this.username, this.email);
  DMUser(this.email, this.username, this.profilePicture, this.friends);

  DMUser.setUser(this.username, this.friends, this.profilePicture);

  DMUser.setFriend(this.friends);

  DMUser.fromFirestore(QueryDocumentSnapshot doc) {
    this.username = doc.id;
    this.email = doc['email'];
  }

  Map<String, dynamic> toFirestore() => {
        'username': username,
        'friends': friends,
        'profilePicture': profilePicture,
      };
}
