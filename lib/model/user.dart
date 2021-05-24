import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:turnkey_solution/model/osago.dart';

class UserApp with ChangeNotifier {
  String id;
  String _name;
  String _seName;
  String _lastName;
  String _number;
  String _email;
  List<Osago> _osago = [];

  UserApp.fromFirebase(User user) {
    id = user.uid;
    _email = user.email;
    name = name;
    seName = name;
  }
  setData(UserApp user) {
    name = user.name;
    //seName = user.seName;
    lastName = user.lastName;
    number = user.number;
  }

  String get name => _name;
  void set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get seName => _seName;
  void set seName(String value) {
    _seName = value;
    notifyListeners();
  }

  String get lastName => _lastName;
  void set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  String get number => _number;
  void set number(String value) {
    _number = value;
    notifyListeners();
  }

  String get email => _email;
  void set email(String value) {
    _email = value;
    notifyListeners();
  }

  List<Osago> get osago => _osago;
  void set osago(List<Osago> osagoList) {
    _osago = osagoList;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "seName": seName,
      "lastName": lastName,
      "number": number,
      "id": id,
      "email": email,
      "osago": osago.map((o) => o.toMap()).toList()
    };
  }

  UserApp.fromJson(String uid, Map<String, dynamic> data) {
    id = uid;
    name = data['name'];
    seName = data['seName'];
    lastName = data['lastName'];
    number = data['number'];
    email = data['email'];
    osago = (data['osago'] ?? []);
  }

  String get getId => id;
}
