import 'package:dm_music/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/sign_in_screen.dart';

class AuthStateSwitch extends StatelessWidget {
  final DmMusic app;
  AuthStateSwitch({@required this.app});

  Widget _buildSplash(String msg) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(msg)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasError) {
          return _buildSplash(snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildSplash("loading...");
            break;
          case ConnectionState.active:
            {
              final user = snapshot.data;
              if (user == null) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: SignInScreen(),
                );
              }else
              {
              app.currentUserEmail = user.email;
              return this.app;
              }
            }
            break;
          case ConnectionState.done:
            final user = snapshot.data;
            app.currentUserEmail = user.email;
            return _buildSplash("unreachable (done!)");
          default:
            return _buildSplash("unreachable (none)");
        }
      },
    );
  }
}
