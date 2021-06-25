//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:murcuryapp/views/chatRoomsScreen.dart';
import 'package:murcuryapp/widgets/widget.dart';

import 'ProfileScreen.dart';
import 'ServerSettings.dart';
import 'chat.dart';

//import 'XD_Login.dart';
////import 'chat.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 0;
  int bodyIndex = 0;
  final List<Widget> _screens = [
    ChatRoom(),
    //chat(),
    // ServerSettings(),
    ProfileScreen()
  ];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //    Get screen dimensions
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    String serverName = "Mercury";
    DecorationImage serverImage = DecorationImage(
      image: AssetImage('assets/images/Helmet w_DropShadow.png'),
      fit: BoxFit.scaleDown,
    );
    String userName = "default user";
    DecorationImage userImage = DecorationImage(
      image: AssetImage('assets/images/testUserImage.png'),
      fit: BoxFit.scaleDown,
    );

    //Hide Status Bar
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.transparent,)
//        );
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      key: _scaffoldKey,
      appBar: appBarMain(context),
      body: _screens[bodyIndex],
//      drawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            Container(
//              color: Color(0xFF5D6FA6),
//              child: DrawerHeader(
////              margin: EdgeInsets.all(10),
//                child: Text(
//                  serverName,
//                  style: TextStyle(
//                    color: Color(0xFFFFFFFF),
//                  ),
//                ),
//                decoration: BoxDecoration(
//                  color: Color(0xFF5D6FA6),
//                  image: serverImage,
//                ),
//              ),
//            ),
//            Container(
//              color: Color(0xFF3F528C),
//              child: ListTile(
//                title: Text(
//                  'Server 1',
//                  style: TextStyle(
//                    color: Color(0xFFFFFFFF),
//                  ),
//                ),
//                onTap: () {},
//              ),
//            ),
//          ],
//        ),
//      ),
//      endDrawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            Container(
//              color: Color(0xFF5D6FA6),
//              child: InkWell(
//                onTap: () {
////                  Navigator.pushNamed(context, "/profile");
//                  setState(() {
//                    bodyIndex = 3;
//                  });
//                  Navigator.pop(context);
//                },
//                child: DrawerHeader(
////              margin: EdgeInsets.all(10),
//                  child: Text(
//                    userName,
//                    style: TextStyle(
//                      color: Color(0xFFFFFFFF),
//                    ),
//                  ),
//                  decoration: BoxDecoration(
//                    color: Color(0xFF5D6FA6),
//                    image: userImage,
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              color: Color(0xFF3F528C),
//              child: ListTile(
//                title: Text(
//                  'Channel 1',
//                  style: TextStyle(
//                    color: Color(0xFFFFFFFF),
//                  ),
//                ),
//                onTap: () {},
//              ),
//            ),
//          ],
//        ),
//      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFF5D6FA6),
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            backgroundColor: Colors.white,
            title: Text(
              'Message User',
              style: TextStyle(color: Colors.white),
            ),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.chat),
//            backgroundColor: Colors.white,
//            title: Text(
//              'Group Chat',
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            backgroundColor: Colors.white,
            title: Text(
              'User Settings',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void changeTab(int value) {
    setState(() {
      _currentIndex = value;
      bodyIndex = _currentIndex;
    });
  }
}
