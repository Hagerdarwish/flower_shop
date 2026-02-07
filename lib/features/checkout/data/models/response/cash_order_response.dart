import 'package:json_annotation/json_annotation.dart';

import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart'
    as domain;

part 'cash_order_response.g.dart';

@JsonSerializable()
class CashOrderResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "order")
  final Order order;

  CashOrderResponse({required this.message, required this.order});

  factory CashOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CashOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashOrderResponseToJson(this);

  domain.CashOrderModel toDomain() {
    return domain.CashOrderModel(
      id: order.id,
      userId: order.user,
      items: order.orderItems.map((e) => e.toDomain()).toList(),
      totalPrice: order.totalPrice.toDouble(),
      paymentType: order.paymentType,
      isPaid: order.isPaid,
      isDelivered: order.isDelivered,
      state: order.state,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      orderNumber: order.orderNumber,
    );
  }
}

@JsonSerializable()
class Order {
  @JsonKey(name: "user")
  final String user;
  @JsonKey(name: "orderItems")
  final List<OrderItem> orderItems;
  @JsonKey(name: "totalPrice")
  final int totalPrice;
  @JsonKey(name: "paymentType")
  final String paymentType;
  @JsonKey(name: "isPaid")
  final bool isPaid;
  @JsonKey(name: "isDelivered")
  final bool isDelivered;
  @JsonKey(name: "state")
  final String state;
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "orderNumber")
  final String orderNumber;
  @JsonKey(name: "__v")
  final int v;

  Order({
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  final Product product;
  @JsonKey(name: "price")
  final int price;
  @JsonKey(name: "quantity")
  final int quantity;
  @JsonKey(name: "_id")
  final String id;

  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  domain.OrderItem toDomain() {
    return domain.OrderItem(
      id: id,
      product: product.toDomain(),
      price: price.toDouble(),
      quantity: quantity,
    );
  }
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "slug")
  final String slug;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "imgCover")
  final String imgCover;
  @JsonKey(name: "images")
  final List<String> images;
  @JsonKey(name: "price")
  final int price;
  @JsonKey(name: "priceAfterDiscount")
  final int priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int quantity;
  @JsonKey(name: "category")
  final String category;
  @JsonKey(name: "occasion")
  final String occasion;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "__v")
  final int v;
  @JsonKey(name: "isSuperAdmin")
  final bool isSuperAdmin;
  @JsonKey(name: "sold")
  final int sold;
  @JsonKey(name: "rateAvg")
  final int rateAvg;
  @JsonKey(name: "rateCount")
  final int rateCount;
  @JsonKey(name: "id")
  final String productId;

  Product({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  domain.Product toDomain() {
    return domain.Product(
      id: id,
      title: title,
      description: description,
      imgCover: imgCover,
      price: price.toDouble(),
      priceAfterDiscount: priceAfterDiscount.toDouble(),
      quantity: quantity,
      category: category,
    );
  }
}
