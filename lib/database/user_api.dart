import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_api_task/models/app_user.dart';
import 'package:firebase_api_task/widgets/custom_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserAPI {
  static const String _collection = 'users';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  // functions
  Future<DocumentSnapshot<Map<String, dynamic>>> getInfo(
      {required String uid}) async {
    return _instance.collection(_collection).doc(uid).get();
  }

  Future<bool> addUser(AppUser appUser) async {
    await _instance
        .collection(_collection)
        .doc(appUser.uid)
        .set(appUser.toMap())
        .catchError((Object e) {
      CustomToast.successToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<String> uploadImage(File? file, String uid) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('usersImages').child(uid);
    await ref.putFile(file!);
    String url = await ref.getDownloadURL();
    return url;
  }
}
