import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      //String token=;
      print('token=${await _fcm.getToken()}');
      return 'Signed in';
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed up';
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

}