import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../song.dart';

class SongPreviewScreen extends StatefulWidget {
  final Song song;
  final bool isLoggedUserSong;

  SongPreviewScreen(this.song, this.isLoggedUserSong);
  @override
  _SongPreviewScreenState createState() => _SongPreviewScreenState();
}

class _SongPreviewScreenState extends State<SongPreviewScreen>
    with SingleTickerProviderStateMixin {
  bool liked;
  AnimationController animationController;
  Animation _sizeAnim, _rotationAnim;

  @override
  void initState() {
    liked = false;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _sizeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 25, end: 35), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 35, end: 25), weight: 3),
    ]).animate(animationController);

    _rotationAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 360), weight: 1),
    ]).animate(animationController);

    super.initState();
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _likeSong() {
    if (!liked) {
      widget.song.likes++;
      liked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.song.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                label: Text(
                  widget.song.likes.toString(),
                ),
                icon: Container(
                  width: 36,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      return Transform.rotate(
                        angle: _rotationAnim.value * math.pi / 180.0,
                        child: Icon(
                          Icons.star,
                          size: _sizeAnim.value,
                          color: liked ? Colors.yellow : Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                onPressed: () {
                  if (!widget.isLoggedUserSong) {
                    setState(() {
                      animationController.forward();
                      _likeSong();
                    });
                  }
                },
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey[350],
        body: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Text(widget.song.lyrics,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context).pop(widget.song);
      },
    );
  }
}
