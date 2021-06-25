import 'package:murcuryapp/helper/constants.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/views/conversation_screen.dart';
import 'package:murcuryapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//SearchScreen Widget
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

//SearchScreen State
class _SearchScreenState extends State<SearchScreen> {

  //New instance of Database Methods
  DatabaseMethods databaseMethods = new DatabaseMethods();
  //New instance of Text Editing Controller
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  //Allows the users to search by user or email
  Widget searchList() {
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapshot.documents[index].data["name"],
            userEmail: searchSnapshot.documents[index].data["email"],
          );
        }) : Container();
  }

  //sets the searchSnapshot state in preparation for being used ??
  initiateSearch(){
    databaseMethods.getUserByUserEmail(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  //Widget Returned to Display Searched users
  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumTextStyle(),),
              Text(userEmail, style: mediumTextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createPrivateChat(
                userEmail: userEmail
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF2573d9),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message", style: mediumTextStyle(),),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }


  /// create chatroom, send user to conversation screen, push replacement
  createPrivateChat({String userEmail}) {
    if(userEmail != Constants.myEmail) {
      String chatRoomId =  getChatRoomId([userEmail, Constants.myEmail]);

      //Add Master accounts to test group messaging?
      List<String> users = [userEmail, Constants.myEmail];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId
      };

      //Creating chat room in database
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);

      //Pushing to a ConversationScreen based off of the chatRoomId
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId
          )
      ));
    } else {
      print("You cannot send message to yourself");
    }
  }

  removeDuplicates(List<String> list) {
    list.sort();
    List<String> duplicates = [];

    for(int i = 0; i < list.length; i++) {
      for(int o = 0; o < list.length; o++) {
        if(list[i] == list[o] && i != o) {
          duplicates.add(list[i]);
        }
      }
    }

    for(int i = 0; i < list.length; i++) {
      for(int o = 0; o < duplicates.length; o++) {
        if(list[i] == duplicates[o]) {
          list.remove(list[i]);
        }
      }
    }

    return list;
  }

  //???
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff505050),
      appBar: appBarSearch(context),
      //???
      body: Container(
        child: Column(
          children: [
            Container(
              color:  Colors.black26,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //???
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: "search email...",
                        hintStyle: TextStyle(
                          color: Colors.white70
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  //???
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    //???
                    child: Container(
                      height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all((12)),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            //???
            searchList()
          ],
        ),
      ),
    );
  }
}

//Generates ChatroomID
getChatRoomId(List<String> emails) {
  emails.sort();
  String chatroomId= '';

  for(int i = 0; i < emails.length; i++) {
    if(i == emails.length-1) {
      chatroomId += '${emails[i]}';
    } else {
      chatroomId += '${emails[i]} ';
    }
  }

  return chatroomId;
}