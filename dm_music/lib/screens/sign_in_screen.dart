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

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 116, 66, 117)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.63);
    path_0.quadraticBezierTo(size.width * 0.10, size.height * 0.66,
        size.width * 0.20, size.height * 0.63);
    path_0.cubicTo(size.width * 0.32, size.height * 0.58, size.width * 0.23,
        size.height * 0.53, size.width * 0.41, size.height * 0.49);
    path_0.cubicTo(size.width * 0.63, size.height * 0.47, size.width * 0.61,
        size.height * 0.36, size.width * 0.81, size.height * 0.36);
    path_0.quadraticBezierTo(
        size.width * 0.93, size.height * 0.33, size.width, size.height * 0.25);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 106, 43, 108)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.60);
    path_1.quadraticBezierTo(size.width * 0.78, size.height * 0.61,
        size.width * 0.73, size.height * 0.58);
    path_1.cubicTo(size.width * 0.67, size.height * 0.56, size.width * 0.63,
        size.height * 0.51, size.width * 0.69, size.height * 0.46);
    path_1.cubicTo(size.width * 0.71, size.height * 0.41, size.width * 0.50,
        size.height * 0.39, size.width * 0.49, size.height * 0.35);
    path_1.cubicTo(size.width * 0.42, size.height * 0.29, size.width * 0.47,
        size.height * 0.23, size.width * 0.55, size.height * 0.19);
    path_1.cubicTo(size.width * 0.65, size.height * 0.16, size.width * 0.67,
        size.height * 0.18, size.width * 0.74, size.height * 0.14);
    path_1.cubicTo(size.width * 0.81, size.height * 0.11, size.width * 0.75,
        size.height * 0.07, size.width * 0.82, size.height * 0.03);
    path_1.quadraticBezierTo(
        size.width * 0.85, size.height * 0.01, size.width, 0);

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 109, 0, 112)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(0, size.height * 0.52);
    path_2.quadraticBezierTo(size.width * 0.21, size.height * 0.51,
        size.width * 0.30, size.height * 0.47);
    path_2.cubicTo(size.width * 0.40, size.height * 0.44, size.width * 0.41,
        size.height * 0.34, size.width * 0.51, size.height * 0.31);
    path_2.cubicTo(size.width * 0.63, size.height * 0.27, size.width * 0.71,
        size.height * 0.30, size.width * 0.81, size.height * 0.27);
    path_2.cubicTo(size.width * 0.90, size.height * 0.25, size.width * 0.96,
        size.height * 0.22, size.width * 0.99, size.height * 0.18);
    path_2.quadraticBezierTo(
        size.width * 0.99, size.height * 0.14, size.width, 0);
    path_2.lineTo(0, 0);

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
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
          //BackgroundRect(widhtPercentage: 0.7, heightPercentage: 0.45),
          Container(
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context)
                      .size
                      .height), //You can Replace this with your desired WIDTH and HEIGHT
              painter: RPSCustomPainter(),
            ),
          ),
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
                SizedBox(height: 40),
                Container(
                  height: 45,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    color: Color.fromARGB(255, 106, 43, 108),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      _signInWithEmailWithPassword(
                        email: _email.text,
                        password: _password.text,
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontFamily: "FredokaOne",
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
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
