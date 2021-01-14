import 'package:dm_music/screens/add_friends_screen.dart';
import 'package:dm_music/screens/main_screens/home_screen.dart';
import 'package:dm_music/screens/main_screens/user_profile_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:dm_music/widgets/bottom_bar.dart';
import 'package:dm_music/widgets/title.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatefulWidget {
  final DMUser user;

  SocialScreen(this.user);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.user.friends);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomBar(3, widget.user),
      body: Stack(
        children: [
          BackgroundMainScreen(),
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SectionTitle("Friends", color: Colors.white),
              SizedBox(height: 10),
              FriendsList(widget: widget),
            ],
          ),
        ],
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SocialScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.user.friends.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.user.friends.length) {
            return AddFriendIcon(widget: widget);
          } else {
            return FriendIcon(socialScreen: widget, index: index);
          }
        },
      ),
    );
  }
}

class AddFriendIcon extends StatelessWidget {
  const AddFriendIcon({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SocialScreen widget;

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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddFriendsScreen(widget.user),
            ));
          },
        ),
        SizedBox(height: 1),
        Text(
          "Add Friend",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class FriendIcon extends StatefulWidget {
  final SocialScreen socialScreen;

  const FriendIcon({
    Key key,
    @required this.socialScreen,
    @required this.index,
  }) : super(key: key);

  final int index;

  DMUser _getFriend(String user){

  }

  @override
  _FriendIconState createState() => _FriendIconState();
}

class _FriendIconState extends State<FriendIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(getRandomImage(), height: 60),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfileScreen(widget.socialScreen.user, false);
                },
              ),
            );
          },
        ),
        SizedBox(height: 1),
        Text(
          widget.socialScreen.user.friends[widget.index],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "FredokaOne",
            fontStyle: FontStyle.normal,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
