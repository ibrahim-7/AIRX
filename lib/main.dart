import 'package:fifth_project/splash/mycustomsplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(AIRX());
}

class AIRX extends StatefulWidget {
  @override
  _AIRX createState() => _AIRX();
}

class _AIRX extends State<AIRX> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: 'AIRX - A News App',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyCustomSplashScreen(),
      ),
    );
  }
}
