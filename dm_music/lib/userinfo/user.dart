import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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

  DMUser.update() {
    StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('users').doc(email).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          username = snapshot.data['username'];
          profilePicture = snapshot.data['profilePiscture'];
          friends = snapshot.data['friends'];
        }
      },
    );
  }

  Map<String, dynamic> toFirestore() => {
        'username': username,
        'friends': friends,
        'profilePicture': profilePicture,
      };
}
