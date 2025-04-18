import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:commerceapp/models/Cart_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  CollectionReference get _cartRef =>
      _firestore.collection('carts').doc(userId).collection('items');

  Future<void> addToCart(CartItem item) async {
    final existing = await _cartRef
        .where('productId', isEqualTo: item.productId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      final currentQty = doc['quantity'] ?? 1;
      await doc.reference.update({'quantity': currentQty + 1});
    } else {
      await _cartRef.add(item.toMap());
    }
  }

  Stream<List<CartItem>> getCartItems() {
    return _cartRef.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> removeItem(String id) async {
    await _cartRef.doc(id).delete();
  }

  Future<void> clearCart() async {
    final snapshot = await _cartRef.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
