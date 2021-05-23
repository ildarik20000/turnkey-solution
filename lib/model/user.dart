import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  String id;
  String name;
  String seName;
  String lastName;
  String number;
  String email;

  UserApp.fromFirebase(User user) {
    id = user.uid;
    email = user.email;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "seName": seName,
      "lastName": lastName,
      "number": number,
      "id": id,
      "email": email
    };
  }

  UserApp.fromJson(String uid, Map<String, dynamic> data) {
    id = uid;
    name = data['name'];
    seName = data['seName'];
    lastName = data['lastName'];
    number = data['number'];
    email = data['email'];
  }

  String get getId => id;
}
