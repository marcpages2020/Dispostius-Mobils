import 'package:cloud_firestore/cloud_firestore.dart';

class DMUser {
  String username;
  String email;
  String profilePicture;
  List<dynamic> friends;

  //DMUser(this.username, this.email);
  DMUser(QueryDocumentSnapshot snapshot) {
    username = snapshot.get("username");
    //email = snapshot.get("email");
    friends = snapshot.get("friends");
  }

  DMUser.fromNewFirestore(QueryDocumentSnapshot doc) {
    this.username = doc.id;
    this.email = doc['email'];
  }

  Map<String, dynamic> toFirestore() => {
        'id': username,
        'email': email,
        'friends': friends,
      };
}

class NewUser {
  String username;
  String email;
  List<dynamic> friends;
  NewUser(this.username, this.friends);

  Map<String, dynamic> toFirestore() => {
        'username': username,
        'friends': friends,
      };
}
