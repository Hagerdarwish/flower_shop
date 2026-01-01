import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final bool? isSuperAdmin;

  const CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        image,
        createdAt,
        updatedAt,
        isSuperAdmin,
      ];
}
