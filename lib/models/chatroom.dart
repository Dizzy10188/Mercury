import 'package:flutter/material.dart';
import 'package:murcuryapp/models/message.dart';
import 'package:murcuryapp/models/user.dart';

//???
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

//???
class _ChatRoomState extends State<ChatRoom> {

  //???
  @override
  Widget build(BuildContext context) {
    //???
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Chat-Room'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
            Column(
              children: <Widget>[],

            ),
        ],
      ),
    );
  }
}
