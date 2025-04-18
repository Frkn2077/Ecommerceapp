import 'package:flutter/material.dart';
import 'package:commerceapp/services/product_service.dart';
import 'package:commerceapp/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Tümü';

  final List<String> categories = [
    'Tümü',
    'Telefon',
    'Laptop',
    'Aksesuar',
    'Giyim',
    'Ev Eşyası',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürünler")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
              items: categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: selectedCategory == 'Tümü'
                  ? ProductService().getAllProducts()
                  : ProductService().getProductsByCategory(selectedCategory),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data!;
                if (products.isEmpty) {
                  return const Center(child: Text("Bu kategoride ürün yok."));
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl, width: 50),
                      title: Text(product.name),
                      subtitle: Text("${product.price} ₺"),
                      trailing: Text(product.category),
                      onTap: () {
                        // Ürün detay ekranına geçiş
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
