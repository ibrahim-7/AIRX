import 'dart:async';
import 'dart:convert';
import 'package:fifth_project/api/embed.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Lobby/lobby.dart';
import '../api/category.dart';
import '../api/sort.dart';
import '../feed/newpageshortmain.dart';

// ignore: camel_case_types
class Sort extends StatefulWidget {
  Sort({
    required this.id,
  });
  String id;
  @override
  _SortState createState() => _SortState();
}

List bookmarkid = [];

// ignore: camel_case_types
class _SortState extends State<Sort> with ChangeNotifier {
  Future<dynamic>? httpdata;
  bool showbottombar = true;
  var post;
  bool iconselected = false;

  var mItemCount = 10;
  var postdate;
  late PageController bookmarkcontroller = PageController();
  PageController autoplaycontroller = PageController();

  @override
  void initState() {
    super.initState();

    httpdata = fetchmoresort(widget.id, 0);
    catfetchpost();
    checklist();
  }

  Future setbookmark(List<dynamic> ids) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ids", json.encode(ids));
  }

  Future getbookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idvalue = prefs.getString("ids");
    return jsonDecode(idvalue!);
  }

  checklist() async {
    final idvalue = await getbookmark() ?? 0;

    bookmarkid = idvalue as List;
  }

  int currentIndex = 0;
  onchanged(int index) {
    setState(() {
      currentIndex = index;

      if (bookmarkid.contains(post['id'])) {
        iconselected = true;
      } else {
        iconselected = false;
      }
    });
    if (index + 3 == sortlist.length) {
      setState(() {
        fetchmoresort(widget.id, sortlist.length);
      });
    }
  }

  void changePageViewPostion(int whichPage) {
    whichPage = whichPage + 1; // because position will start from 0
    double jumpPosition = MediaQuery.of(context).size.width / 2;
    double orgPosition = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < mItemCount; i++) {
      bookmarkcontroller.jumpTo(jumpPosition);
      if (i == whichPage) {
        break;
      }
      jumpPosition = jumpPosition + orgPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            changePageViewPostion(-1);
          });
        },
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.arrow_upward_outlined),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (d) {
              return lobby();
            }));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: primarycolor,
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: showbottombar
          ? Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            iconselected = !iconselected;
                          });
                          if (iconselected == true) {
                            bookmarkid.add(post['id']);
                            setbookmark(bookmarkid);
                          } else {
                            bookmarkid.remove(post['id']);
                            setbookmark(bookmarkid);
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.bookmark,
                              size: 20,
                              color: iconselected ? redcolor : blackcolor,
                            ),
                            Text('Bookmark'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                            "Gallinews \n" +
                                post['link'] +
                                " \n Dated On: " +
                                DateFormat('EEE, MMM d').format(postdate),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.share,
                              size: 20,
                            ),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: Builder(
        builder: (context) {
          return OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return !connected
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          color: Colors.red,
                          height: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons
                                    .signal_cellular_connected_no_internet_4_bar_outlined,
                                size: 28,
                              ),
                              Text(
                                'No Internet ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Please Check Your Connection',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : child;
            },
            child: GestureDetector(
              onTap: () => setState(() {
                showbottombar = !showbottombar;
              }),
              child: FutureBuilder(
                future: httpdata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PageView.builder(
                      scrollDirection: Axis.vertical,
                      onPageChanged: onchanged,
                      itemCount: sortlist.length,
                      controller: autoplaycontroller,
                      itemBuilder: (context, id) {
                        post = sortlist[id];

                        var embedattrcategory;
                        embedattrcategory = post['categories'];
                        postdate = DateTime.parse(post['date']);
                        //  parse html
                        var description = parse(post['content']['rendered']);
                        String parseddesc =
                            parse(description.body!.text).documentElement!.text;

                        var heading = parse(post['title']['rendered']);
                        String head =
                            parse(heading.body!.text).documentElement!.text;

                        // for each to get categories
                        embedattrcategory.forEach((j) {
                          catnewslist.forEach((v) {
                            if (j == v['id']) {
                              catresult = v['name'];
                            }
                          });
                        });

                        return newspageshortmain(
                          shortdescription: parseddesc,
                          shortimage: post['_embedded']['wp:featuredmedia'][0]
                              ['source_url'],
                          shortheading: head,
                          longimage: post['_embedded']['wp:featuredmedia'][0]
                              ['source_url'],
                          longheading: head,
                          longdescription: parseddesc,
                          newstype: catresult,
                          time: DateFormat('EEE, MMM d, yyyy \n hh:mm a')
                              .format(postdate),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
