import 'package:flutter/material.dart';
import 'package:murcuryapp/helper/authenticate.dart';
import 'package:murcuryapp/services/auth.dart';
import 'package:murcuryapp/views/ChatScreen.dart';
import 'package:murcuryapp/views/groupSearch.dart';

AuthMethods authMethods = new AuthMethods();

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF5D6FA6),
    title: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        },
        child: Image.asset(
          "assets/images/Logo.png",
          height: 40.0,
        )),
    actions: [
      GestureDetector(
        onTap: () {
          authMethods.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Authenticate()));
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app)),
      ),
    ],
  );
}

Widget appBarSearch(BuildContext context) {
  return AppBar(
    title: Row(
      children: <Widget>[
        Image.asset(
          "assets/images/Logo.png",
          height: 40.0,
        ),
        FlatButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GroupSearchScreen()))
          },
          child: Text(
            'Create Group Chat',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          color: Color(0xFF5D6FA6),
        )
      ],
    ),
    backgroundColor: Color(0xFF5D6FA6),
  );
}

//???
InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

//???
TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

//???
TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
