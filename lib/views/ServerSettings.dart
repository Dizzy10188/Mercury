//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
//import 'XD_Login.dart';

class ServerSettings extends StatefulWidget {
  ServerSettings({
    Key key,
  }) : super(key: key);

  @override
  _ServerSettingsState createState() => _ServerSettingsState();
}

class _ServerSettingsState extends State<ServerSettings> {
  String testString = "settings";
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
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Text(
              'Server Settings'
          )
        ],
      ),
    );
  }
}
