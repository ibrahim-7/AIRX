import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';

class card extends StatelessWidget {
  const card({
    required this.icon,
    required this.title,
    Key? key,
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primarycolor,
            size: 30,
          ),
          SizedBox(height: 10),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
