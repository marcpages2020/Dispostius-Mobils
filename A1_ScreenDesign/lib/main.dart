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
          /*
          Container(
            color: Colors.lightGreen,
            height: 400,
            width: 400,
            alignment: Alignment.topLeft,
          ),
          */
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'PLAYING NOW',
                    style: TextStyle(color: Colors.white),
                  )
                ],
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
              SizedBox(height: 50),
              SongInformation(),
              Row(children: [
                SizedBox(width: 40),
                Text('Rhye', style: TextStyle(color: Colors.white))
              ])
            ],
          ),
        ],
      ),
    );
  }
}

class SongInformation extends StatelessWidget {
  const SongInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            'Last Dance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          height: 10,
          child: Icon(
            Icons.favorite,
            color: Colors.yellowAccent,
          ),
        ),
      ],
    );
  }
}
