import 'package:cloud_firestore/cloud_firestore.dart';

class DMUser {
  String username;
  String email;
  String profilePicture;
  List<dynamic> friends;

  //DMUser(this.username, this.email);
  DMUser(QueryDocumentSnapshot snapshot){
    username = snapshot.id;
    email = snapshot.get("email");
    friends = snapshot.get("friends");
  }

  DMUser.fromFirestore(DocumentSnapshot doc) {
    this.username = doc.id;
    this.email = doc['email'];
  }

  Map<String, dynamic> toFirestore() => {
        'id': username,
        'email': email,
      };
}
