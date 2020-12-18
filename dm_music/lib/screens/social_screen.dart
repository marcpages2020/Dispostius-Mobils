import 'dart:math';

import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatefulWidget {
  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    final DMUser user = Provider.of<DMUser>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(3),
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ), //You can Replace this with your desired WIDTH and HEIGHT
              painter: CustomPainterMainScreen(
                Colors.deepPurple,
                Colors.grey[900],
                Colors.lime[500],
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "Friends",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "FredokaOne",
                  fontStyle: FontStyle.normal,
                  fontSize: 34,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FriendList(user.friends),
            ],
          ),
        ],
      ),
    );
  }
}

class FriendList extends StatelessWidget {
  final List<dynamic> friends;
  FriendList(this.friends);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: friends.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == friends.length) {
              return AddFriendIcon();
            } else {
              return FriendIcon(friends[index]);
            }
          }),
    );
  }
}

class FriendIcon extends StatelessWidget {
  final String name;

  FriendIcon(this.name);

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int user = random.nextInt(4) + 1;

    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/users_pictures/$user.jpg',
              height: 60,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 1),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        )
      ],
    );
  }
}

class AddFriendIcon extends StatelessWidget {
  String name;

  AddFriendIcon();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Colors.black,
              child: Icon(
                Icons.add_circle_outline_rounded,
                size: 60,
                color: Colors.limeAccent[700],
              ),
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 1),
        Text(
          "Add Friend",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
          ),
        )
      ],
    );
  }
}
