import 'package:murcuryapp/helper/helperfunctions.dart';
import 'package:murcuryapp/services/auth.dart';
import 'package:murcuryapp/services/database.dart';
import 'package:murcuryapp/views/ChatScreen.dart';
import 'package:murcuryapp/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameTextEditingController =
      new TextEditingController();
  TextEditingController lastNameTextEditingController =
      new TextEditingController();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      userNameTextEditingController.text = firstNameTextEditingController.text.trim() +" "+ lastNameTextEditingController.text.trim();

      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
      };

      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text.trim());
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text.trim());

      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text.trim(),
              passwordTextEditingController.text.trim())
          .then((val) {
//        print("${val.uid}");
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
//      appBar: appBarMain(context),
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
                  offset: Offset(0.0, screenHeight * .28),
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
                                      return val.isEmpty || val.length < 2
                                          ? "First Name Can't Be Empty Or Less Than One Character"
                                          : null;
                                    },
                                    controller: firstNameTextEditingController,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        hintText: "First Name"),
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return val.isEmpty || val.length < 2
                                          ? "Last Name Can't Be Empty Or Less Than One Character"
                                          : null;
                                    },
                                    controller: lastNameTextEditingController,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        hintText: "Last Name"),
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)
                                          ? null
                                          : "Enter An Email";
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
                                  TextFormField(
                                    obscureText: true,
                                    validator: (val){
                                      Pattern  pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                      RegExp regExp = new RegExp(pattern);
                                      return !regExp.hasMatch(val) ? 'Password Needs To Be 8+ Characters Long,\n One Special Characeter,\n One Number,\n One Captial Letter' : null;
                                    },
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
                            SizedBox(
                              height: 8,
                            ),
//                      Container(
//                          alignment: Alignment.centerRight,
//                          child: Container(
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: 16, vertical: 8),
//                              child: Text("Forgot Password?",
//                                  style: simpleTextStyle()))),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                signMeUp();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      const Color(0xff083da6),
                                      const Color(0xff0634bf),
                                      const Color(0xff0634bf),
                                    ]),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Text(
                                  "Sign Up",
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
                                  "Already have account? ",
                                  style: mediumTextStyle(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Sign In",
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
