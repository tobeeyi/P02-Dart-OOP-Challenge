import 'exception.dart';
import 'mixin.dart';

enum OrderStatus { pending, preparing, delivered, cancelled }

abstract class MenuItem {
  final String id;
  final String name;
  final double basePrice;

  MenuItem({
    required this.id,
    required this.name,
    required this.basePrice,
  }) {
    if (basePrice <= 0) {
      throw InvalidOrderException('Harga item harus lebih besar dari 0');
    }
  }

  Map<String, dynamic> toJson();
}

class FoodItem extends MenuItem with Discountable {
  final String spicyLevel;

  FoodItem({
    required super.id,
    required super.name,
    required super.basePrice,
    required this.spicyLevel,
  });

  double getFinalPrice(double discountPercentage) {
    return applyDiscount(basePrice, discountPercentage);
  }

  FoodItem copyWith({
    String? id,
    String? name,
    double? basePrice,
    String? spicyLevel,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      basePrice: basePrice ?? this.basePrice,
      spicyLevel: spicyLevel ?? this.spicyLevel,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'basePrice': basePrice,
      'spicyLevel': spicyLevel,
    };
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      spicyLevel: json['spicyLevel'] as String,
    );
  }
}

class Order {
  final String orderId;
  final List<FoodItem> items;
  final OrderStatus status;
  final String? note;

  Order({
    required this.orderId,
    required this.items,
    this.status = OrderStatus.pending,
    this.note,
  }) {
    if (items.isEmpty) {
      throw InvalidOrderException('Pesanan tidak boleh kosong tanpa item!');
    }
  }

  double calculateTotal(double discountPercentage) {
    double total = 0;
    for (var item in items) {
      total += item.getFinalPrice(discountPercentage);
    }
    return total;
  }

  Order copyWith({
    String? orderId,
    List<FoodItem>? items,
    OrderStatus? status,
    String? note,
  }) {
    return Order(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status.name,
      'note': note,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] as String,
      items: (json['items'] as List)
          .map((itemJson) => FoodItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      status: OrderStatus.values.firstWhere((e) => e.name == json['status']),
      note: json['note'] as String?,
    );
  }
}
