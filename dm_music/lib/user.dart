import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String profilePicture;

  User(this.username, this.email);

  User.fromFirestore(DocumentSnapshot doc) {
    this.username = doc.id;
    this.email = doc['email'];
  }

  Map<String, dynamic> toFirestore() => {
        'id': username,
        'email': email,
      };
}
