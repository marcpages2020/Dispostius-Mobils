import 'package:cloud_firestore/cloud_firestore.dart';
import '../../animations/animated_route.dart';
import 'package:flutter/material.dart';

import '../../userinfo/user.dart';
import '../main_screens/home_screen.dart';
import 'sign_in_screen.dart';

class EmailAndPassword {
  String email, password;
  EmailAndPassword(this.email, this.password);
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _email, _password, _username;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(children: [
        BackgroundSignInFlow(),
        Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TopElements(),
              SizedBox(height: 15),
              Container(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 54,
                    color: Colors.black,
                    fontFamily: "FredokaOne",
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(height: 80),
              TextInput(
                  controller: _email,
                  hint: 'Enter Your Email',
                  label: 'Email',
                  hide: false),
              SizedBox(height: 24),
              TextInput(
                controller: _password,
                hint: 'Enter Your Password',
                label: 'Password',
                hide: true,
              ),
              SizedBox(height: 24),
              TextInput(
                controller: _username,
                hint: 'Enter Your Username',
                label: 'Username',
                hide: false,
              ),
              SizedBox(height: 30),
              SignUp(
                email: _email,
                password: _password,
                username: _username,
              ),
              Return()
            ],
          ),
        ),
      ]),
    );
  }
}

class TopElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            hoverColor: Colors.black,
            color: Colors.black,
            focusColor: Colors.black,
            splashRadius: 22.0,
            onPressed: () {
              Navigator.of(context).pop(
                AnimatedRoute.createRoute(
                  scene: SignInScreen(),
                  curves: Curves.easeOut,
                  offset: Offset.infinite,
                  durationMilli: 500,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Return extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Return to..',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: "FredokaOne",
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(width: 6),
            FlatButton(
              textColor: Colors.white,
              child: Text('Sign in',
                  style: TextStyle(
                    fontFamily: "FredokaOne",
                    fontStyle: FontStyle.normal,
                  )),
              onPressed: () {
                Navigator.of(context).pop(
                  AnimatedRoute.createRoute(
                    scene: SignInScreen(),
                    curves: Curves.easeOut,
                    offset: Offset.infinite,
                    durationMilli: 500,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  SignUp({
    Key key,
    @required TextEditingController email,
    @required TextEditingController password,
    @required TextEditingController username,
  })  : _email = email,
        _password = password,
        _username = username,
        super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _username;
  final List<String> friends = [];
  final String profilePicture = getRandomImage();
  final String title = "Add Song";
  final String artist = "";
  final String album = "";
  final String albumCoverUrl = "";
  final String lyrics = "";
  final int likes = 0;

  final users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          alignment: Alignment.centerLeft,
          child: FlatButton(
            color: Colors.lime[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              Navigator.of(context).pop(
                EmailAndPassword(_email.text, _password.text),
              );

              users.doc(_email.text.toLowerCase()).set(
                  DMUser.setUser(_username.text, friends, profilePicture)
                      .toFirestore());

              //users.doc(_email.text.toLowerCase()).collection('songs');
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 34,
                color: Colors.black,
                fontFamily: "FredokaOne",
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
