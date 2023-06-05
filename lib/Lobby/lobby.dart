import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:fifth_project/mainpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../About/about.dart';
import 'Categories.dart';
import 'lobbybanners.dart';
import 'lobbylabel.dart';
import 'lobbysuggestedtopics.dart';

class lobby extends StatefulWidget {
  const lobby({Key? key}) : super(key: key);

  @override
  _lobbyState createState() => _lobbyState();
}

class _lobbyState extends State<lobby> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (d) {
                return settings();
              }));
            },
            child: Icon(
              Icons.info_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Discover',
            style: TextStyle(
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (d) {
                  return mainPage();
                }));
              },
              icon: Icon(
                Icons.double_arrow_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Press again to exit',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: primarycolor,
            dismissDirection: DismissDirection.down,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                lobbybanners(),
                lobbylabel(labelname: 'CATEGORIES'),
                Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: MediaQuery.of(context).size.width / 2,
                    color: primarycolor),
                Categories(),
                lobbylabel(labelname: 'SUGGESTED TOPICS'),
                Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: MediaQuery.of(context).size.width / 3,
                    color: primarycolor),
                lobbysuggestedtopics(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
