import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:murcuryapp/helper/authenticate.dart';
import 'package:murcuryapp/helper/constants.dart';
import 'package:murcuryapp/helper/helperfunctions.dart';
import 'package:murcuryapp/services/auth.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/views/search.dart';
import 'package:murcuryapp/widgets/widget.dart';

import 'conversation_screen.dart';

//???
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

//???
class _ChatRoomState extends State<ChatRoom> {
  //???
  AuthMethods authMethods = new AuthMethods();

  //???
  DatabaseMethods databaseMethods = new DatabaseMethods();

  //???
  Stream chatRoomsStream;

  //???
  Widget chatRoomsList() {
    return StreamBuilder(
      //???
      stream: chatRoomsStream,
      //???
      builder: (context, snapshot) {
        //???
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data["chatroomId"]
                          .toString()
                          .replaceAll("_", " ")
                          //.replaceAll(Constants.myName, "")
                          .replaceAll(Constants.myEmail, ""),
                      snapshot.data.documents[index].data["chatroomId"]);
                })
            : Container();
      },
    );
  }

  //???
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  //???
  getUserInfo() async {
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    print(Constants.myEmail);
    print(Constants.myName);
    databaseMethods.getChatRooms(Constants.myEmail).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {});
  }

  //???
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff505050),
//      appBar: AppBar(
//        title: Image.asset(
//          "assets/images/Logo.png",
//          height: 40.0,
//        ),
//        actions: [
//          GestureDetector(
//            onTap: () {
//              authMethods.signOut();
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (context) => Authenticate()));
//            },
//            child: Container(
//                padding: EdgeInsets.symmetric(horizontal: 16),
//                child: Icon(Icons.exit_to_app)),
//          ),
//        ],
//      ),
      body: chatRoomsList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2573d9),
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

//???
class ChatRoomsTile extends StatelessWidget {
  final String userEmail;
  final String chatRoomId;

  //???
  ChatRoomsTile(this.userEmail, this.chatRoomId);

  //???
  @override
  Widget build(BuildContext context) {
    //???
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      //???
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userEmail.trim().substring(0, 1).toUpperCase()}",
                style: mediumTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                userEmail,
                style: mediumTextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
