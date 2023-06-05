import 'package:fifth_project/api/bookmark_detail.dart';
import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:html/parser.dart';

class detail_bookmark extends StatefulWidget {
  detail_bookmark({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  State<detail_bookmark> createState() => _detail_bookmarkState();
}

class _detail_bookmarkState extends State<detail_bookmark> {
  @override
  void initState() {
    super.initState();
    fetchsinglebookmark(widget.id);
    bookcontroller = PageController();
  }

  var mItemCount = 10;
  late PageController bookcontroller;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
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
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     setState(() {
      //       changePageViewPostion(-1);
      //     });
      //   },
      //   child: Icon(
      //     Icons.assistant_navigation,
      //     size: 40,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            child: FutureBuilder<dynamic>(
              future: fetchsinglebookmark(widget.id),
              builder: (context, snapshot) {
                var post = detail_book[0];
                var postdate = DateTime.parse(post['date']);
                //  parse html
                var description = parse(post['content']['rendered']);
                String parseddesc =
                    parse(description.body!.text).documentElement!.text;

                var heading = parse(post['title']['rendered']);
                String head = parse(heading.body!.text).documentElement!.text;

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(post['_embedded']['wp:featuredmedia'][0]
                            ['source_url']),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                head,
                                style: TextStyle(
                                  color: primarycolor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                parseddesc,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
