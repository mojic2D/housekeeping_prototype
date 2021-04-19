import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:housekeeping_prototype/services/app_data.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      //String token=;
      final token = await FirebaseMessaging.instance.getToken();
      print('token=$token');
      final uid = _firebaseAuth.currentUser.uid;
      AppData.sendLoginData(
          email: email, password: password, uid: uid, token: token);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      return e.code;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
