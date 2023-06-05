import 'package:fifth_project/api/sort.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../sort/Sort.dart';
import 'card.dart';

class lobbysuggestedtopics extends StatelessWidget {
  const lobbysuggestedtopics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: [
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(
                    id: "20551",
                  ),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Sports', icon: Icons.sports),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(
                    id: "20541",
                  ),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'India', icon: Icons.rule_sharp),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(id: "20547"),
                  duration: const Duration(milliseconds: 400),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Politics', icon: Icons.health_and_safety),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(
                    id: "20542",
                  ),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Film', icon: Icons.business_rounded),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(id: "20539"),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Crime', icon: Icons.video_label_rounded),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(id: "20540"),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Delhi', icon: Icons.map_sharp),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(id: "20543"),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child: card(title: 'Maharastra', icon: Icons.memory_sharp),
        ),
        GestureDetector(
          onTap: () => {
            sortlist = [],
            Navigator.push(
              context,
              PageTransition(
                  child: Sort(id: "20545"),
                  type: PageTransitionType.leftToRightWithFade),
            ),
          },
          child:
              card(title: 'Navi Mumbai', icon: Icons.add_location_alt_outlined),
        ),
      ],
    );
  }
}
