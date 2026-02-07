import 'package:equatable/equatable.dart';

class CashOrderModel extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderNumber;

  const CashOrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
  ];
}

class OrderItem extends Equatable {
  final String id;
  final Product product;
  final double price;
  final int quantity;

  const OrderItem({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, product, price, quantity];
}

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final double price;
  final double priceAfterDiscount;
  final int quantity;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imgCover,
    price,
    priceAfterDiscount,
    quantity,
    category,
  ];
}
