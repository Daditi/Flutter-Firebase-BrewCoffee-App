import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebasebrewcoffee/models/user.dart';
import 'package:flutterfirebasebrewcoffee/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // craete user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }

  // auth change user stream, when the user is longed in it will pass the user id and logedout null, just like the above function,
  // it passes stream of data whenever there is a change in authentication
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
}

  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user =result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user after register by passing uid to the constructor and some dummy values
      await DatabaseService(uid:user.uid).updateUserData('0', 'Newly Registered', 100);

      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


// sign out
Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
}

}