import 'dart:convert';
import 'package:fifth_project/api/bookmark.dart';
import 'package:fifth_project/bookmarkpage/detail_bookmark.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Lobby/lobby.dart';

import '../api/category.dart';

class bookmarkpage extends StatefulWidget {
  const bookmarkpage({Key? key}) : super(key: key);

  @override
  _bookmarkpageState createState() => _bookmarkpageState();
}

class _bookmarkpageState extends State<bookmarkpage> {
  var idvalue;
  _getbookmarkids() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idvalue = prefs.getString('ids');
    });

    return jsonDecode(idvalue);
  }

  @override
  void initState() {
    super.initState();
    _getbookmarkids();
    fetchcategory(idvalue);
    catfetchpost();
  }

  Widget build(BuildContext context) {
    var post;
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
          'Bookmarks',
          style: TextStyle(
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
                          color: Color(0xFFEE4400),
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
            child: idvalue == null
                ? Center(
                    child: Text(
                      "NO BOOKMARKS ADDED",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: primarycolor,
                        letterSpacing: 4,
                      ),
                    ),
                  )
                : FutureBuilder<dynamic>(
                    future: fetchcategory(idvalue),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: ((context, index) {
                            return SizedBox(height: 10);
                          }),
                          itemCount: uicatnewslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            post = uicatnewslist[index];
                            var postdate = DateTime.parse(post['date']);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (x) {
                                  return detail_bookmark(id: post['id']);
                                }));
                              },
                              child: Card(
                                shadowColor: primarycolor,
                                elevation: 8,
                                child: ListTile(
                                  leading: Image.network(
                                    post['_embedded']['wp:featuredmedia'][0]
                                        ['source_url'],
                                    width: 50,
                                  ),
                                  title: Text(
                                    post['title']['rendered'],
                                    maxLines: 3,
                                  ),
                                  trailing: Text(
                                    DateFormat('EEE, MMM d').format(postdate),
                                    style: TextStyle(),
                                  ),
                                ),
                              ),
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
          );
        },
      ),
    );
  }
}
