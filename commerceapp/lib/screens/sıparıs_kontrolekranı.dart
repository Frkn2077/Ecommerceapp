import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';
import '../models/Cart_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "₺${product.price}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final cartService = CartService();
                final cartItem = CartItem(
                  id: '',
                  productId: product.id,
                  name: product.name,
                  price: product.price,
                  quantity: 1,
                  imageUrl: product.imageUrl,
                );
                await cartService.addToCart(cartItem);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Ürün sepete eklendi")));
              },

              child: const Text("Sepete Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}
