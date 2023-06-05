import 'package:fifth_project/api/sort.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:fifth_project/highlights/highlights.dart';
import 'package:fifth_project/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../bookmarkpage/bookmarkpage.dart';
import '../sort/Sort.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 5),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: bookmarkpage(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
                child: cat_options(
                  icon: Icons.bookmark,
                  title: "Bookmarks",
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (s) {
                      return mainPage();
                    }),
                  )
                },
                child: cat_options(
                  icon: Icons.amp_stories_sharp,
                  title: "Feed",
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return Highlights();
                  }))),
                },
                child: cat_options(
                  icon: Icons.newspaper,
                  title: "Highlights",
                ),
              ),
              GestureDetector(
                onTap: () => {
                  sortlist = [],
                  Navigator.push(
                    context,
                    PageTransition(
                        child: Sort(id: "20544"),
                        type: PageTransitionType.leftToRightWithFade),
                  ),
                },
                child: cat_options(
                  icon: Icons.location_city_outlined,
                  title: "Mumbai",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cat_options extends StatelessWidget {
  cat_options({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  String title;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primarycolor,
            size: 35,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
