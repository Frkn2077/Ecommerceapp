import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart' as myorder;

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("Kullanıcı oturumu açık değil!");
    }
    return user.uid;
  }

  // Sipariş oluşturma
  Future<void> createOrder(myorder.Order order) async {
    try {
      final orderRef = _firestore
          .collection('orders')
          .doc(userId)
          .collection('user_orders');

      await orderRef.add(order.toMap());
    } catch (e) {
      print("Sipariş oluşturma hatası: $e");
      rethrow;
    }
  }

  // Kullanıcının tüm siparişlerini getir
  Future<List<myorder.Order>> getUserOrders() async {
    try {
      final snapshot =
          await _firestore
              .collection('orders')
              .doc(userId)
              .collection('user_orders')
              .orderBy('date', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return myorder.Order.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      print("Siparişleri alırken hata: $e");
      return [];
    }
  }
}
