import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:murcuryapp/helper/constants.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/widgets/widget.dart';
import 'package:flutter/material.dart';

// Main widget
class ConversationScreen extends StatefulWidget {
  String chatRoomId;

  // Setting Conversation screens ChatroomID
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ScrollController _scrollController = new ScrollController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  // creates new text editing controller
  TextEditingController messageController = new TextEditingController();

  // new stream of chat messages
  Stream chatMessagesStream;

  //
  Widget ChatMessageList() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    print("=====================================>>>>>>>>>> State Changed");

    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] ==
                          Constants.myName);
                })
            : Container();
      },
    );
  }

  scrollBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
//    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  // ???
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      //???
      setState(() {
        //???
        chatMessagesStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double height = 0;
    if (screenHeight < 500) {
      height = screenHeight * .2;
    } else {
      height = screenHeight * .1;
    }
//    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    return Scaffold(
      backgroundColor: Color(0xff404040),
      appBar: appBarMain(context),
      //???
      body: Container(
        child: Column(
          children: [
            Expanded(
//              height: screenHeight*.828,
              child: ChatMessageList(),
            ),
            Container(
              height: height,
              alignment: Alignment.bottomCenter,
              //???
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color(0x54FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                //???
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down),
                        alignment: Alignment.topLeft,
                        iconSize: 40,
                        onPressed: () => scrollBottom(),
                      ),
                    ),
                    Expanded(
                      //???
                      child: TextField(
                        onTap: () {
                          Timer(Duration(milliseconds: 200), () {
                            scrollBottom();
                          });
                        },
                        controller: messageController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none),
                      ),
                    ),
                    //???
                    GestureDetector(
                      onTap: () {
                        Timer(Duration(milliseconds: 300), () {
                          scrollBottom();
                        });
                        sendMessage();
//                        print("===================>>>>>>>>>"+screenHeight.toString());
                      },
                      //???
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all((12)),
                          child: Image.asset("assets/images/send.png")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  //???
  final String message;

  //???
  final bool isSendByMe;

  //???
  MessageTile(this.message, this.isSendByMe);

  //???
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: isSendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0xE1FFFFFF), const Color(0xE1FFFFFF)]),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: isSendByMe ? Colors.white : Color(0xff505050),
              fontSize: 17),
        ),
      ),
    );
  }
}
