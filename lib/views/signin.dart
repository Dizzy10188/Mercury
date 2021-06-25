import 'package:murcuryapp/helper/helperfunctions.dart';
import 'package:murcuryapp/services/auth.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/views/ChatScreen.dart';
import 'package:murcuryapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text.trim());

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text.trim())
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.documents[0].data["name"]);
      });

        setState(() {
//          isLoading = true;
        });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text.trim(),
              passwordTextEditingController.text.trim())
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatScreen()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //    Get screen dimensions
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
//    double offset = .4;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Stack(
              children: <Widget>[
                // Adobe XD layer: 'ColorBack' (shape)
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/ColorBack.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Transform.translate(
                  offset: Offset(35.0, 26.0),
                  child:
                      // Adobe XD layer: 'DropShadow' (shape)
                      Container(
                    width: 167.0,
                    height: 176.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/Logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, screenHeight * .3),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (val) {
                                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                          ? null
                                          : "Enter A Correct Email";
                                    },
                                    controller: emailTextEditingController,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        hintText: "Email"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    //validator: (val){
                                      //Pattern  pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                      //RegExp regExp = new RegExp(pattern);
                                      //return !regExp.hasMatch(val) ? 'Password Is Invalid' : null;
                                    //},
                                    controller: passwordTextEditingController,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        hintText: "Password"),
                                  ),
                                ],
                              ),
                            ),
//                      Container(
//                          alignment: Alignment.centerRight,
//                          child: Container(
//                              padding:
//                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                              child: Text("Forgot Password?",
//                                  style: simpleTextStyle()))),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                signIn();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
//                                const Color(0xff083da6),
                                      const Color(0xff0634bf),
                                      const Color(0xff0634bf),
                                    ]),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Text(
                                  "Sign In",
                                  style: mediumTextStyle(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: mediumTextStyle(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Color(0xFFf2cb57),
                                          fontSize: 17,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
