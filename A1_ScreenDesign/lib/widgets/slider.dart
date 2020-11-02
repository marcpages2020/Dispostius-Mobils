import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final int durationMinutes;
  final int durationSeconds;

  SliderWidget(
      {@required this.durationMinutes, @required this.durationSeconds});

  @override
  SliderState createState() => SliderState();
}

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    Size sizeWithOverflow,
    double textScaleFactor,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final fill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = sliderTheme.thumbColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fill);
    canvas.drawCircle(center, thumbRadius, border);
  }
}

class TrackShape extends RoundedRectSliderTrackShape {
  final double trackWidth;

  const TrackShape({
    this.trackWidth,
  });

  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class SliderState extends State<SliderWidget> {
  double _sliderValue = 64;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
                thumbShape: CircleThumbShape(thumbRadius: 6.0),
                activeTrackColor: Colors.lime[400],
                trackHeight: 3,
                trackShape: TrackShape(),
                thumbColor: Colors.lime[400]),
            child: Slider(
              value: _sliderValue,
              min: 0,
              max: widget.durationMinutes.toDouble() * 60 +
                  widget.durationSeconds.toDouble(),
              inactiveColor: Colors.grey[850],
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ),
        ),
        Row(
          children: [
            Container(
              child: Text(
                '${parseToMinutesSeconds(_sliderValue)}',
                style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Text(
                '${parseToMinutesSeconds(widget.durationMinutes.toDouble() * 60 + widget.durationSeconds.toDouble())}',
                style: TextStyle(
                  color: Colors.grey[850],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              alignment: Alignment.centerRight,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
      ],
    );
  }
}

String parseToMinutesSeconds(double ms) {
  String data;
  Duration duration = Duration(milliseconds: ms.toInt() * 1000);

  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds) - (minutes * 60);

  data = minutes.toString() + ":";
  if (seconds <= 9) data += "0";

  data += seconds.toString();
  return data;
}
