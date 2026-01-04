class AllCategoriesModel {
  final String? message;
  final MetadataModel? metadata;
  final List<CategoryItemModel?>? categories;

  AllCategoriesModel({this.message, this.metadata, this.categories});
}

class CategoryItemModel {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final bool? isSuperAdmin;
  final int? productsCount;

  CategoryItemModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.productsCount,
  });
}

class MetadataModel {
  final int? currentPage;
  final int? limit;
  final int? totalPages;
  final int? totalItems;

  MetadataModel({
    this.currentPage,
    this.limit,
    this.totalPages,
    this.totalItems,
  });
}
