import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHandler {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseFirestore = FirebaseFirestore.instance;

  static void login(String email, String password) async {
    await AuthenticationHandler.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static void register(String email, String password, String userName) async {
    final newUser = await AuthenticationHandler.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await firebaseFirestore.collection('users').doc(newUser.user!.uid).set({
      'username': userName,
      'email': email,
      'userId': newUser.user!.uid,
      'starred': [],
    });
  }
}
