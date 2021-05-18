import 'package:firebase_auth/firebase_auth.dart';
import 'package:turnkey_solution/model/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserApp> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return UserApp.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<UserApp> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return UserApp.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<UserApp> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User user) => user != null ? UserApp.fromFirebase(user) : null);
  }
}
