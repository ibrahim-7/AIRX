import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class newspageshortsub extends StatefulWidget {
  const newspageshortsub({
    Key? key,
    required this.shortimage,
    required this.shortheading,
    required this.shortdescription,
    required this.typesofnews,
    required this.time,
    // required this.load,
  }) : super(key: key);
  final String shortheading, shortdescription, typesofnews, shortimage;
  final String time;
  // final CircularProgressIndicator load;
  @override
  State<newspageshortsub> createState() => _newspageshortsubState();
}

class _newspageshortsubState extends State<newspageshortsub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              // height: 240,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    widget.shortimage,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.grey[300],
                    child: Center(
                        child: Text(
                      widget.typesofnews,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Text(
                    widget.time.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shortheading,
                  maxLines: 3,
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.shortdescription,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  maxLines: 9,
                ),
                SizedBox(height: 5),
                Text(
                  'Swipe left for more Details',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
