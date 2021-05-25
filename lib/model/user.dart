import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:turnkey_solution/model/kasko.dart';
import 'package:turnkey_solution/model/osago.dart';

class UserApp with ChangeNotifier {
  String id;
  String _name;
  String _seName;
  String _lastName;
  String _number;
  String _email;
  List<Osago> _osago = [];
  List<Kasko> _kasko = [];

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

  List<Kasko> get kasko => _kasko;
  void set kasko(List<Kasko> kaskoList) {
    _kasko = kaskoList;
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
      "osago": osago.map((o) => o.toMap()).toList(),
      "kasko": kasko.map((o) => o.toMap()).toList(),
    };
  }

  UserApp.fromJson(String uid, Map<String, dynamic> data) {
    id = uid;
    name = data['name'];
    seName = data['seName'];
    lastName = data['lastName'];
    number = data['number'];
    email = data['email'];

    if (data["osago"] != null)
      osago = List<Osago>.from(data["osago"].map((i) => Osago.fromJson(i)));
    if (data["kasko"] != null)
      kasko = List<Kasko>.from(data["kasko"].map((i) => Kasko.fromJson(i)));
  }

  String get getId => id;
}
