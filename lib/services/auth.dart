
import 'package:doctor_consult/models/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
Stream<User> get user => _auth.authStateChanges();
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
        await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User user = _auth.currentUser;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
     await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User user = _auth.currentUser;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}