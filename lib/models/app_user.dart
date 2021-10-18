import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  const AppUser({
    this.uid,
    this.name,
    this.imageURL,
    this.password,
    this.email,
  });
  final String? uid;
  final String? name;
  final String? imageURL;
  final String? password;
  final String? email;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'imageURL': imageURL,
      'password': password,
      'email': email,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> docs) {
    return AppUser(
      uid: docs.data()!['uid'].toString(),
      name: docs.data()!['name'].toString(),
      imageURL: docs.data()!['imageURL'].toString(),
      password: docs.data()!['password'].toString(),
      email: docs.data()!['email'].toString(),
    );
  }
}
