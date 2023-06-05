import 'package:flutter/material.dart';

class lobbylabel extends StatelessWidget {
  const lobbylabel({
    Key? key,
    required this.labelname,
  }) : super(key: key);

  final String labelname;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          labelname,
          style: TextStyle(
              letterSpacing: 3, fontSize: 19, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
