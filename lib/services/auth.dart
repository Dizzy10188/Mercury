import 'package:murcuryapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
//      await DatabaseService(uid: user.uid).updateUserData('Dizzy');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

    Future updateWithEmailAndPassword({String password, String firstName, String lastName}) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      UserUpdateInfo userUpdate  = UserUpdateInfo();

      user.updateEmail(user.email);

      if(password != null){
        await user.updatePassword(password);
        await user.reload();
      }
 
      if(firstName != null && lastName == null){
        print("First If");
        lastName = user.displayName.substring(user.displayName.indexOf(" "), user.displayName.length);
        userUpdate.displayName = "${firstName} ${lastName}";
        await user.updateProfile(userUpdate);
        await user.reload();
      }else if(firstName == null && lastName != null){
        firstName = user.displayName.substring(0, user.displayName.indexOf(" "));
        userUpdate.displayName = "${firstName} ${lastName}";
        print("Else If");
        await user.updateProfile(userUpdate);
        await user.reload();
      }else{
        print("Else\n${firstName} ${lastName}");
        userUpdate.displayName = "${firstName} ${lastName}";
        await user.updateProfile(userUpdate);
        await user.reload();
      }
      userUpdate.displayName = "${firstName} ${lastName}";
      await user.updateProfile(userUpdate);
      await user.reload();
      await print("Final: ${user.displayName}");

      if(firstName != null || lastName != null || password != null){
        print("Return");
        return user;
      }
      else{
        print("Else Return");
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  Future testPrint() async {
    FirebaseUser user = await _auth.currentUser();
    print(user.email);
    print(user.displayName);
  }


  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
