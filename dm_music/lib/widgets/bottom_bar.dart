import 'package:dm_music/screens/main_screens/home_screen.dart';
import 'package:dm_music/screens/main_screens/search_screen.dart';
import 'package:dm_music/screens/main_screens/social_screen.dart';
import 'package:dm_music/screens/main_screens/user_profile_screen.dart';
import 'package:dm_music/userinfo/user.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int _myIndex;
  final DMUser user;

  BottomBar(this._myIndex, this.user);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _onItemTapped(int index) {
    if (index == widget._myIndex) return;

    setState(
      () {
        switch (index) {
          case 0:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchScreen(widget.user)));
            break;
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(widget.user)));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserProfileScreen(widget.user, true)));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SocialScreen(widget.user)));
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity), label: "Profile"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt), label: "Social"),
      ],
      currentIndex: widget._myIndex,
      onTap: _onItemTapped,
    );
  }
}
