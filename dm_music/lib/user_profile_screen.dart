import 'package:dm_music/widgets/horizontal_list.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 80,
              ),
              SizedBox(height: 30),
              Text(
                "username",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              Row(
                children: [
                  //HorizontalList(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
