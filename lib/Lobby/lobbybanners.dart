import 'package:fifth_project/api/sort.dart';
import 'package:fifth_project/sort/Sort.dart';
import 'package:flutter/material.dart';

class lobbybanners extends StatelessWidget {
  const lobbybanners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                sortlist = [];
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Sort(id: "20625");
                })));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/image/coronovirus.jfif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                sortlist = [];
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Sort(id: "20538");
                })));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/image/breakingnews.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
