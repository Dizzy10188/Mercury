//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murcuryapp/helper/constants.dart';
import 'package:murcuryapp/helper/loading.dart';
import 'package:murcuryapp/services/auth.dart';
import 'package:murcuryapp/views/ChatScreen.dart';
import 'package:murcuryapp/views/signin.dart';
import '';
import 'dart:ui' as ui;

import 'chatRoomsScreen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }


  final AuthMethods _auth = AuthMethods();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String password = null;
  String firstName = null;
  String lastName = null;

  static var arr = Constants.myName.split(" ");

  String current_FirstName = arr[0];
  String current_LastName = arr[1];

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xff505050),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(9),
                      ),
                      hintText: current_FirstName),
                  validator: (val){
                    return val.contains(" ") ? 'First Name Can\'t Have Spaces' : null;
                  },
                  onChanged: (val) {
                    setState(() => firstName = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  // initialValue: u.displayName.substring(u.displayName.indexOf(" "), u.displayName.length+1),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(9),
                      ),
                      hintText: current_LastName),
                  validator: (val){
                    return val.contains(" ") ? 'Last Name Can\'t Have Spaces' : null;
                  },
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                ),
//                SizedBox(height: 20.0),
//                TextFormField(
//                  // initialValue: u.email,
//                  decoration: InputDecoration(
//                      filled: true,
//                      fillColor: Colors.white,
//                      border: OutlineInputBorder(
//                        borderRadius:
//                        BorderRadius.circular(9),
//                      ),
//                      hintText: current_Email),
//                  // ignore: missing_return
//                  validator: (val){
//                    if(val.isNotEmpty){
//                    Pattern  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
//                    RegExp regExp = new RegExp(pattern);
//                    return !regExp.hasMatch(val) ? 'Must Be In The Format Of An Email' : null;
//                    }
//                  },
//                  onChanged: (val) {
//                    setState(() => email = val);
//                  },
//                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(9),
                      ),
                      hintText: 'Password'),
                  obscureText: true,
                  validator: (val) {
                    if(!val.isEmpty){
                    Pattern  pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regExp = new RegExp(pattern);
                    return !regExp.hasMatch(val) ? '8+ Characters Long,\n One Special Characeter,\n One Number,\n One Captial Letter' : null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      if(!val.isEmpty){
                       password = val;
                    }
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                  color: Color(0xFF2573d9),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // print(password);
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      print("Password: ${password}\nFirst Name: ${firstName}\nLast Name: ${lastName}");
                      dynamic result = await _auth.updateWithEmailAndPassword(password: password, firstName: firstName, lastName: lastName);
                         _auth.testPrint();
                         print(result);
                         if(result != null) {
                          setState(() {
                            loading = false;
                            _auth.signOut();
                            Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => SignIn(toggleView)));
                          });
                        }
                        else{
                          setState(() {
                            loading = false;
                            error = "No Changes Made";
                          });
                        }
                    }
                  }
                ),
                SizedBox(height: 12.0),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                  color: Colors.grey[350],
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                  }
                ),
                SizedBox(height: 12.0),
                Center(child: 
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
                ,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
