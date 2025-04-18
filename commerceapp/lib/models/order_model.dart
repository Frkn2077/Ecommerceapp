import 'cart_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
  });

  factory Order.fromMap(Map<String, dynamic> data, String id) {
    final itemsData = List<Map<String, dynamic>>.from(data['items']);
    return Order(
      id: id,
      items: itemsData.map((e) => CartItem.fromMap(e, '')).toList(),
      total: (data['total'] ?? 0).toDouble(),
      date: DateTime.parse(data['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'date': date.toIso8601String(),
    };
  }
}
