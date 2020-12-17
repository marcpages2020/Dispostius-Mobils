import 'package:dm_music/animations/animated_route.dart';
import 'package:dm_music/widgets/background_rect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _email, _password;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _showError(error) {
    String message;
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case "wrong-password":
        case "user-not-found":
          message = "Wrong user/password combination";
          break;
        case "invalid-email":
          message = "The email is invalid";
          break;
        case "too-many-requests":
          message = "Too many login attempts. Try again later";
          break;
        case "weak-password":
          message = "The password is too weak";
          break;
        default:
          message = "FirebaseAuth Error: ${error.code}";
      }
    } else {
      message = "General Error: $error";
    }
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    //   backgroundColor: Colors.red,
    //));
  }

  void _signInWithEmailWithPassword({String email, String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // } on FirebaseAuthException catch (e) {
      //  _showError(e);
    } catch (e) {
      _showError(e);
    }
  }

  void _createUserWithEmailAndPassword({String email, String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      _showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundRect(widhtPercentage: 0.7, heightPercentage: 0.45),
          Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Container(
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 54,
                      color: Colors.black,
                      fontFamily: "FredokaOne",
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(height: 130),
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: "FredokaOne",
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 40),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 40,
                        child: IconButton(
                          iconSize: (50),
                          icon: Icon(Icons.play_arrow),
                          hoverColor: Colors.black,
                          color: Colors.black,
                          highlightColor: Colors.grey[900],
                          splashRadius: 52.0,
                          onPressed: () {
                            _signInWithEmailWithPassword(
                              email: _email.text,
                              password: _password.text,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Need an account?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "FredokaOne",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(width: 6),
                        FlatButton(
                          textColor: Colors.white,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontFamily: "FredokaOne",
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              AnimatedRoute.createRoute(
                                scene: SignUpScreen(),
                                offset: Offset.zero,
                                curves: Curves.easeOut,
                                durationMilli: 500,
                              ),
                            )
                                .then((result) {
                              _createUserWithEmailAndPassword(
                                email: result.email,
                                password: result.password,
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    Key key,
    @required TextEditingController controller,
    @required String hint,
    @required String label,
    @required bool hide,
  })  : _controller = controller,
        _hint = hint,
        _label = label,
        _hide = hide,
        super(key: key);

  final TextEditingController _controller;
  final String _hint;
  final String _label;
  final bool _hide;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _hide,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        hintText: _hint,
        labelText: _label,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: "FredokaOne",
          fontStyle: FontStyle.normal,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontFamily: "FredokaOne",
        fontStyle: FontStyle.normal,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
