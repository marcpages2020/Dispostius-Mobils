import 'package:cloud_firestore/cloud_firestore.dart';

class DMUser {
  String username;
  String email;
  String profilePicture;
  List<String> friends;

  //DMUser(this.username, this.email);
  DMUser(String g_email, String g_username, String g_profilePicture) {
    email = g_email;
    username = g_username;
    profilePicture = g_profilePicture;
  }

  DMUser.setUser(this.username, this.friends, this.profilePicture);

  DMUser.fromNewFirestore(QueryDocumentSnapshot doc) {
    this.username = doc.id;
    this.email = doc['email'];
  }

  Map<String, dynamic> toFirestore() => {
        'username': username,
        'friends': friends,
        'profilePicture': profilePicture,
      };
}
