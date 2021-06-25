//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
//import 'XD_Login.dart';

class chat extends StatefulWidget {
  chat({
    Key key,
  }) : super(key: key);

  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  String testString = "yeet";
  int testInt = 0;

  @override
  Widget build(BuildContext context) {
    //    Get screen dimensions
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    //Hide Status Bar
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.transparent,)
//        );
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: const Color(0xff404040),
      body: Stack(
        children: <Widget>[
            Container(
              child: Text(
                "yeet"
              ),
            )
        ],
      ),
    );
  }
}
