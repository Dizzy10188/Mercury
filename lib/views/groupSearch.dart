import 'package:murcuryapp/helper/constants.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/views/conversation_screen.dart';
import 'package:murcuryapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

//SearchScreen Widget
class GroupSearchScreen extends StatefulWidget {
  @override
  _GroupSearchScreenState createState() => _GroupSearchScreenState();
}

//SearchScreen State
class _GroupSearchScreenState extends State<GroupSearchScreen> {

    List<String> emails = [Constants.myEmail];
    String action = 'Add';

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
        setActText(searchSnapshot.documents[0].data["email"]);
      });
    });
  }

  setActText(String email) {
    bool containsUser = false;

    for(int i = 0; i < emails.length; i++) {
      if(emails[i] == email) {
        containsUser = true;
      }
    }

    if(emails.length < Constants.maxUsers) {
      if(containsUser) {
        setState(() {
          action = 'Remove';
        });
      }
      else if (!containsUser) {
        setState(() {
          action = 'Add';
        });
      }
    }
    else {
      if(containsUser) {
        setState(() {
          action = 'Remove';
        });
      }
      else {
        setState(() {
          action = 'Max';
        });
      }

    }
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
            onTap: () {
              bool containsUser = false;

              for(int i = 0; i < emails.length; i++) {
                if(emails[i] == userEmail) {
                  containsUser = true;
                }
              }

              if(emails.length < Constants.maxUsers) {

                if(containsUser) {
                  emails.remove(userEmail);
                  setState(() {
                    action = 'Add';
                  });
                }
                else if (!containsUser) {
                  emails.add(userEmail);
                  setState(() {
                    action = 'Remove';
                  });
                }
              }
              else {
                if(containsUser) {
                  emails.remove(userEmail);
                  setState(() {
                    action = 'Add';
                  });
                }
                else {
                  setState(() {
                    action = 'Max';
                  });
                }

              }

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF5D6FA6),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(action, style: mediumTextStyle(),),
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

  removeDuplicates(List<String> list) {
    if(list != null) {
      list.sort();


      List<String> duplicates = [];

      for (int i = 0; i < list.length; i++) {
        for (int o = 0; o < list.length; o++) {
          if (list[i] == list[o] && i != o) {
            duplicates.add(list[i]);
          }
        }
      }

      for (int i = 0; i < list.length; i++) {
        for (int o = 0; o < duplicates.length; o++) {
          if (list[i] == duplicates[o]) {
            list.remove(list[i]);
          }
        }
      }
    }
    return list;
  }

  createNotes({String email}) {
    String chatRoomId = email;
    List<String> users = [email];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId
    };

    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ChatRoom()
    ));
  }

  createGroupChat({List<String> userList}) {
    userList = removeDuplicates(userList);

    if(userList.length > 1) {
      String chatRoomId =  getChatRoomId(userList);

      List<String> users = userList;
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" : chatRoomId
      };

      //Calls DatabaseMethods class to create the chat room in the database
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);

      //pushes to conversation screen based on chatroomID
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatRoom()
      ));
    }
    else if (userList.length == 1) {
      createNotes(email: userList[0]);
    }
    else {

    }

  }

  //???
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      //???
      body: Container(
        child: Column(
          children: [

            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //???
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: "search email...",
                        hintStyle: TextStyle(
                          color: Colors.white54
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
            searchList(),
            FlatButton(
              onPressed: () {
                createGroupChat(userList: emails);
                emails = [];
              },
              child: Container(
                color: Color(0xFF5D6FA6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create',
                    style:
                    TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Generates ChatroomID
getChatRoomId(List<String> emails) {
  String chatroomId= '';

  if(emails != null) {
  emails.sort();

  for(int i = 0; i < emails.length; i++) {
    if(i == emails.length-1) {
      chatroomId += '${emails[i]}';
    } else {
      chatroomId += '${emails[i]} ';
    }
  }
  }


  return chatroomId;
}