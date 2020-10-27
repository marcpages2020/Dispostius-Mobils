import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Design',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _MainScreen(),
    );
  }
}

class _MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Text(
              'Amazing Text',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(27.0),
            child: Image.asset(
              'assets/images/klpso.jpg',
              width: 300.0,
              height: 330.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
