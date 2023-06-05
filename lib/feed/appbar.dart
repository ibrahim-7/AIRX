import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';

import '../Lobby/lobby.dart';
import '../mainpage.dart';

class appbar extends StatelessWidget with PreferredSizeWidget {
  const appbar({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final mainPage widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (d) {
            return lobby();
          }));
        },
        child: Icon(Icons.arrow_back_ios, color: primarycolor),
      ),
      title: Text(
        'AIRX - A News App',
        style: TextStyle(
          letterSpacing: 3,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      elevation: 5,
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
