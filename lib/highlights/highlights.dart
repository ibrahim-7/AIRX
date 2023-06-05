import 'dart:async';
import 'package:fifth_project/api/category.dart';
import 'package:fifth_project/api/embed.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../Lobby/lobby.dart';

// ignore: camel_case_types
class Highlights extends StatefulWidget {
  @override
  _HighlightsState createState() => _HighlightsState();
}

List bookmarkid = [];

// ignore: camel_case_types
class _HighlightsState extends State<Highlights> {
  Future<dynamic>? httpdata;

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

    httpdata = fetchpost(newslist.length, 60.toString());
    catfetchpost();
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
        fetchpost(newslist.length, 30.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Highlights',
          style: TextStyle(
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
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
            child: FutureBuilder(
                future: httpdata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: newslist.length,
                      itemBuilder: ((context, index) {
                        post = newslist[index];

                        postdate = DateTime.parse(post['date']);

                        var heading = parse(post['title']['rendered']);
                        String head =
                            parse(heading.body!.text).documentElement!.text;

                        return ListTile(
                          style: ListTileStyle.drawer,
                          subtitle: Text(
                            DateFormat('EEEE, MMM d').format(postdate),
                          ),
                          leading: Image.network(
                            post['_embedded']['wp:featuredmedia'][0]
                                ['source_url'],
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(head),
                        );
                      }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          );
        },
      ),
    );
  }
}
