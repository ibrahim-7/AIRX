import 'package:flutter/material.dart';
import 'newspagelong.dart';
import 'newspageshortsub.dart';

class newspageshortmain extends StatefulWidget {
  newspageshortmain({
    required this.shortimage,
    required this.shortheading,
    required this.shortdescription,
    required this.longimage,
    required this.longheading,
    required this.longdescription,
    required this.newstype,
    required this.time,
    // required this.load,
  });
  late String shortheading, shortdescription;
  late String shortimage, longimage;
  late String longheading, longdescription;
  late String newstype;
  late String time;
  // late CircularProgressIndicator load;
  @override
  _newspageshortmainState createState() => _newspageshortmainState();
}

class _newspageshortmainState extends State<newspageshortmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // pageSnapping: false,

        children: [
          newspageshortsub(
            typesofnews: widget.newstype,
            shortimage: widget.shortimage,
            shortheading: widget.shortheading,
            shortdescription: widget.shortdescription,
            time: widget.time,
          ),
          newspagelong(
            time: widget.time,
            newstype: widget.newstype,
            longimage: widget.longimage,
            longheading: widget.longheading,
            longdescription: widget.longdescription,
          ),
        ],
      ),
    );
  }
}
