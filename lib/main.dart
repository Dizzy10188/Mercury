import 'package:murcuryapp/helper/authenticate.dart';
import 'package:murcuryapp/helper/helperfunctions.dart';
import 'package:murcuryapp/views/ChatScreen.dart';
import 'package:murcuryapp/views/chatRoomsScreen.dart';
import 'package:flutter/material.dart';

//Main Method. Runs our application that is being passed in.
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Boolean to tell if the user is logged in or not
  bool userIsLoggedIn;

  // ??
  @override
  void initState() {
    super.initState();
  }

  //function to check whether or not a user is logged in
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  //Main app build function.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercury',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        //??
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ? userIsLoggedIn ? ChatScreen() : Authenticate() : Authenticate(),
//      routes: {
//        '/':(context) => userIsLoggedIn != null ? userIsLoggedIn ? ChatScreen() : Authenticate() : Authenticate(),
////        '/login':(context)=>XD_Login(),
////        '/login':(context)=>SignIn(),
////        '/signup':(context)=>XD_Signup(),
////        '/chat':(context)=>ChatScreen(),
////        '/profile':(context)=>ProfileScreen(),
//      },
    );
  }
}


