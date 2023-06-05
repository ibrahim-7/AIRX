import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';

class newspagelong extends StatefulWidget {
  newspagelong({
    required this.longimage,
    required this.longheading,
    required this.longdescription,
    required this.newstype,
    required this.time,
  });
  final String longimage;
  final String longheading;
  final String longdescription;
  final String newstype;
  final String time;

  @override
  _newspagelongState createState() => _newspagelongState();
}

class _newspagelongState extends State<newspagelong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: false,
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.longimage),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.05,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: Text(
                            widget.newstype,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          widget.time,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 40, left: 5, right: 5),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.longheading,
                          style: TextStyle(
                            color: primarycolor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.longdescription,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
