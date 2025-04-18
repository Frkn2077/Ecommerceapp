import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderService _orderService = OrderService();

  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sipariş Geçmişi")),
      body: FutureBuilder<List<Order>>(
        future: _orderService.getUserOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final orders = snapshot.data!;
          if (orders.isEmpty) return const Center(child: Text("Henüz sipariş verilmedi."));

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text("₺${order.total}"),
                subtitle: Text("Tarih: ${order.date.toLocal()}"),
              );
            },
          );
        },
      ),
    );
  }
}
