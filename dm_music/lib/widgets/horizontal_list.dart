import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      height: 140,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                FlatButton(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/note.png',
                      height: 70,
                    ),
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 4),
                Container(
                  width: 120,
                  height: 30,
                  child: Text(
                    "Blinding Lights",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
