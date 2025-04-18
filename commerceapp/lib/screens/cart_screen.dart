import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  final CartService _cartService = CartService();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sepet")),
      body: StreamBuilder<List<CartItem>>(
        stream: _cartService.getCartItems().map(
          (items) => items.map((item) => item as CartItem).toList(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in cart'));
          } else {
            final cartItems = snapshot.data!;

            double total = 0.0;
            for (var item in cartItems) {
              total += item.price * item.quantity;
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(
                          item.imageUrl,
                          width: 50,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.image),
                        ),
                        title: Text(item.name),
                        subtitle: Text("${item.price} ₺ x ${item.quantity}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _cartService.removeItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Toplam: ${total.toStringAsFixed(2)} ₺",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sipariş ekranı yakında!"),
                            ),
                          );
                        },
                        child: const Text("Siparişi Tamamla"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
