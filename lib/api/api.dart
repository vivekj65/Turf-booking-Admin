import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class APIs {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage imageStore = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getSelfInfo() {
    final turfUser = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots();
    return turfUser;
  }
}
