import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  String id;

  UserApp.fromFirebase(User user) {
    id = user.uid;
  }
}
