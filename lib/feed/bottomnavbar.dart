import 'package:flutter/material.dart';
import 'package:share/share.dart';

class bottomnavbar extends StatefulWidget {
  @override
  _bottomnavbarState createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {
  bool iconselected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    iconselected = !iconselected;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark,
                      size: 20,
                      color: iconselected ? Colors.red : Colors.black,
                    ),
                    Text('Bookmark'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Share.share("AIRX - A News App");
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.share,
                      size: 20,
                    ),
                    Text('Share'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
