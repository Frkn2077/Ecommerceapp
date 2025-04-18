import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String get userId => _auth.currentUser!.uid;

  Future<AppUser?> getUser() async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.data()!, doc.id);
  }

  Future<void> updateUser(AppUser user) async {
    await _firestore.collection('users').doc(userId).set(user.toMap());
  }
}
