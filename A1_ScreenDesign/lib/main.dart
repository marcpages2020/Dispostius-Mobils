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
        primarySwatch: Colors.lime,
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
      body: Stack(
        children: [
          Column(
            children: [
              TopElements(),
              ClipRRect(
                borderRadius: BorderRadius.circular(27.0),
                child: Image.asset(
                  'assets/images/klpso.jpg',
                  width: 375.0,
                  height: 375.0,
                  fit: BoxFit.fill,
                ),
              ),
              Spacer(),
              SongInformation(),
              SizedBox(height: 80),
              Spacer(),
              ControlButtons(),
              Spacer(),
            ],
          ),
        ],
      ),
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
        Icon(
          Icons.expand_more,
          color: Colors.white,
        ),
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            'PLAYING NOW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: 14,
            ),
          ),
        ),
        Icon(
          Icons.queue_music,
          color: Colors.white,
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Dance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rhys',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
        Container(
          child: Icon(
            Icons.favorite,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.shuffle,
          color: Colors.grey,
        ),
        Icon(
          Icons.fast_rewind,
          color: Colors.white,
        ),
        FloatingActionButton(
          mini: false,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.pause,
            size: 30,
          ),
          onPressed: () {},
        ),
        Icon(
          Icons.fast_forward,
          color: Colors.white,
        ),
        Icon(
          Icons.repeat,
          color: Colors.white,
        ),
      ],
    );
  }
}
