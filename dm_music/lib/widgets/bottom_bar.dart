import 'package:dm_music/screens/main_screen.dart';
import 'package:dm_music/screens/search_screen.dart';
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
    if (index == widget._myIndex) return;

    setState(
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => index == 0
                ? SearchScreen()
                : index == 1
                    ? MainScreen()
                    : UserProfileScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            label: "Profile"),
      ],
      currentIndex: widget._myIndex,
      onTap: _onItemTapped,
    );
  }
}
