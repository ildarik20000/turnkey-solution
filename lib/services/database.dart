import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:turnkey_solution/model/user.dart';

class DatabaseService {
  final CollectionReference _userProfileInfo =
      FirebaseFirestore.instance.collection('user');

  Future adduserProfileInfo(UserApp user) async {
    return await _userProfileInfo.doc(user.id).set(user.toMap());
  }

  Stream<List<UserApp>> getInfo(String userId) {
    Query query;
    query = _userProfileInfo.where('id', isEqualTo: userId);

    return query.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => UserApp.fromJson(userId, doc.data()))
        .toList());
  }

  Stream<List<UserApp>> getInfoAll() {
    return _userProfileInfo.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => UserApp.fromJsonAll(doc.data()))
        .toList());
  }
}
