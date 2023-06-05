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

import 'api/category.dart';
import 'feed/newpageshortmain.dart';

// ignore: camel_case_types
class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

List bookmarkid = [];

// ignore: camel_case_types
class _mainPageState extends State<mainPage> {
  Future<dynamic>? httpdata;
  bool showbottombar = true;
  var post;
  bool iconselected = false;
  var currentPageValue = 0.0;
  var mItemCount = 10;
  var postdate;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  var savedindex;
  late PageController bookcontroller;

  @override
  void initState() {
    super.initState();

    httpdata = fetchpost(newslist.length, 10.toString());
    catfetchpost();
    checklist();
    bookcontroller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
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
    final idvalue = await getbookmark();

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
    if (index + 3 == newslist.length) {
      setState(() {
        fetchpost(newslist.length, 10.toString());
      });
    }
  }

  void changePageViewPostion(int whichPage) {
    whichPage = whichPage + 1; // because position will start from 0
    double jumpPosition = MediaQuery.of(context).size.width / 2;
    double orgPosition = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < mItemCount; i++) {
      bookcontroller.jumpTo(jumpPosition);
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
        child: Icon(
          Icons.assistant_navigation,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: primarycolor,
          ),
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
                          print(bookmarkid);
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
                            " AIRX App \n" +
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
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                'Please Check Your Connection',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
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
                      itemCount: newslist.length,
                      controller: bookcontroller,
                      itemBuilder: (context, id) {
                        post = newslist[id];
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
