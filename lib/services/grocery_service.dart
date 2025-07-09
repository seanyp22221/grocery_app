import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroceryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Item
  Future<void> addItem(String item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _db.collection('users').doc(user.uid).collection('grocery').add({
      'name': item,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get Items as Stream
  Stream<QuerySnapshot> getItems() {
    final user = FirebaseAuth.instance.currentUser;
    return _db.collection('users').doc(user!.uid).collection('grocery').orderBy('timestamp').snapshots();
  }

  // Delete item
  Future<void> deleteItem(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    await _db.collection('users').doc(user!.uid).collection('grocery').doc(docId).delete();
  }
}
