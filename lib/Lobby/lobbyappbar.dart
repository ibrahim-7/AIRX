import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../About/about.dart';
import '../mainpage.dart';

class lobbyappbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // top: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: Colors.black,
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: settings(),
                            type: PageTransitionType.leftToRight,
                            reverseDuration: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Icon(Icons.settings, color: primarycolor),
                    ),
                    Text(
                      'DISCOVER',
                      style: TextStyle(
                        color: primarycolor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: mainPage(),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Icon(Icons.keyboard_arrow_right_sharp,
                          color: primarycolor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
