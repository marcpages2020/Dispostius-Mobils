import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dm_music/animations/animated_route.dart';
import 'package:dm_music/widgets/background_rect.dart';
import 'package:dm_music/widgets/custom_painters.dart';
import 'package:flutter/material.dart';

import '../userinfo/user.dart';
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
        Container(
          child: CustomPaint(
            size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context)
                    .size
                    .height), //You can Replace this with your desired WIDTH and HEIGHT
            painter: CustomPainterSignInFlow(
              Colors.lime[200],
              Colors.lime[500],
              Colors.lime[800],
            ),
          ),
        ),
        //BackgroundRect(widhtPercentage: 0.7, heightPercentage: 0.4),
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
  const TopElements({
    Key key,
  }) : super(key: key);

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
  const Return({
    Key key,
  }) : super(key: key);

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
  List<String> friends;
  final String profilePicture = 'assets/users_pictures/4.jpg';

  final users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          alignment: Alignment.centerRight,
          child: FlatButton(
            color: Colors.lime[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              Navigator.of(context).pop(
                EmailAndPassword(_email.text, _password.text),
              );

              users.doc(_email.text).set(
                  DMUser.setUser(_username.text, friends, profilePicture)
                      .toFirestore());
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
