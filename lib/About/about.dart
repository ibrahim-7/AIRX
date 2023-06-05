import 'package:fifth_project/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            'About',
            style: TextStyle(color: primarycolor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: primarycolor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (v) {
                                  return AlertDialog(
                                    actions: [
                                      Image.asset("assets/image/logo.jpg"),
                                    ],
                                  );
                                });
                          },
                          child: Image.asset(
                            "assets/image/logo.jpg",
                          ),
                        ),
                        title: Text("AIRX - A News App"),
                        subtitle: Text("All Rights Reserved"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.38,
                      decoration: BoxDecoration(
                        color: primarycolor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Share.share("AIRX -A News App");
                            },
                            leading: Icon(Icons.share),
                            title: Text("Share App"),
                          ),
                          divider(),
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Version"),
                            subtitle: Text("1.0"),
                          ),
                          divider(),
                          ListTile(
                            leading: Icon(Icons.privacy_tip),
                            title: Text("Feedback"),
                          ),
                          divider(),
                          ListTile(
                            leading: Icon(Icons.rate_review),
                            title: Text("Rate The App"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget divider() {
  return Divider(
    color: Colors.white,
    thickness: 2,
    endIndent: 10,
    indent: 10,
  );
}
