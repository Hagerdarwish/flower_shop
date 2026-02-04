import 'package:json_annotation/json_annotation.dart';
part 'orders_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "orders")
  List<Order>? orders;

  OrderResponse({this.message, this.metadata, this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "limit")
  int? limit;
  @JsonKey(name: "totalItems")
  int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "shippingAddress")
  ShippingAddress? shippingAddress;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "orderItems")
  List<OrderItem>? orderItems;
  @JsonKey(name: "totalPrice")
  int? totalPrice;
  @JsonKey(name: "paymentType")
  PaymentType? paymentType;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "paidAt")
  DateTime? paidAt;
  @JsonKey(name: "isDelivered")
  bool? isDelivered;
  @JsonKey(name: "state")
  State? state;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  String? orderNumber;
  @JsonKey(name: "__v")
  int? v;

  Order({
    this.shippingAddress,
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  Product? product;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

  OrderItem({this.product, this.price, this.quantity, this.id});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  Id? id;
  @JsonKey(name: "title")
  Title? title;
  @JsonKey(name: "slug")
  Slug? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "imgCover")
  String? imgCover;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "category")
  Category? category;
  @JsonKey(name: "occasion")
  Occasion? occasion;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "sold")
  int? sold;
  @JsonKey(name: "rateAvg")
  int? rateAvg;
  @JsonKey(name: "rateCount")
  int? rateCount;
  @JsonKey(name: "id")
  Id? productId;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

enum Category {
  @JsonValue("673c46fd1159920171827c85")
  THE_673_C46_FD1159920171827_C85,
  @JsonValue("673c47751159920171827c93")
  THE_673_C47751159920171827_C93,
}

enum Id {
  @JsonValue("673e2bd91159920171828139")
  THE_673_E2_BD91159920171828139,
  @JsonValue("673e2d1b1159920171828146")
  THE_673_E2_D1_B1159920171828146,
  @JsonValue("6745096c90ab40a0685402fc")
  THE_6745096_C90_AB40_A0685402_FC,
}

enum Occasion {
  @JsonValue("673b34c21159920171827ae0")
  THE_673_B34_C21159920171827_AE0,
  @JsonValue("673b368c1159920171827afc")
  THE_673_B368_C1159920171827_AFC,
}

enum Slug {
  @JsonValue("forever-pink-or-baby-roses")
  FOREVER_PINK_OR_BABY_ROSES,
  @JsonValue("gabrielle-chanel")
  GABRIELLE_CHANEL,
  @JsonValue("red-wdding-flower")
  RED_WDDING_FLOWER,
}

enum Title {
  @JsonValue("Forever Pink | Baby Roses")
  FOREVER_PINK_BABY_ROSES,
  @JsonValue("GABRIELLE CHANEL")
  GABRIELLE_CHANEL,
  @JsonValue("Red Wdding Flower")
  RED_WDDING_FLOWER,
}

enum PaymentType {
  @JsonValue("cash")
  CASH,
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "long")
  String? long;

  ShippingAddress({this.street, this.city, this.phone, this.lat, this.long});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}

enum State {
  @JsonValue("pending")
  PENDING,
}

enum User {
  @JsonValue("6968ecf5e364ef6140464199")
  THE_6968_ECF5_E364_EF6140464199,
}
