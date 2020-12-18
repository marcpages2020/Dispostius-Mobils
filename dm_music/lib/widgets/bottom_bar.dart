import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/screens/search_screen.dart';
import 'package:dm_music/screens/social_screen.dart';
import 'package:dm_music/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int _myIndex;

  BottomBar(this._myIndex);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _onItemTapped(int index) {
    if (index == widget._myIndex) 
    return;

    setState(
      () {
        switch (index) {
          case 0:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchScreen()));
            break;
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainScreen()));
            break;
          case 2:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserProfileScreen()));
            break;
          case 3:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SocialScreen()));
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
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.perm_identity,
          ),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_add,
          ),
          label: "Social",
        ),
      ],
      currentIndex: widget._myIndex,
      onTap: _onItemTapped,
    );
  }
}
