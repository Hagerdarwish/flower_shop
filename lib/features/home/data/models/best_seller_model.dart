import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_model.g.dart';
@JsonSerializable()
class BestSeller {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "id")
  final String? id;

  BestSeller({
    this.Id,
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
    this.id,
  });

  factory BestSeller.fromJson(Map<String, dynamic> json) {
    return _$BestSellerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestSellerToJson(this);
  }

    BestSellerModel toEntity() {
    return BestSellerModel(
      id: id ?? Id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      isSuperAdmin: isSuperAdmin ?? false,
      sold: sold ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
    );
  }
}
