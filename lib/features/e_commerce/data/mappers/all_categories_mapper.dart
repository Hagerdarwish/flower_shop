import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';

extension AllCategoriesMapper on AllCategoriesDto {
  AllCategoriesModel toAllCategoriesModel() {
    return AllCategoriesModel(
      message: message,
      categories: categories?.map((e) => e?.toCategoryItemModel()).toList(),
      metadata: metadata?.toMetaDataModel(),
    );
  }
}

extension CategoryItemMapper on CategoryItemDto {
  CategoryItemModel toCategoryItemModel() {
    return CategoryItemModel(
      id: id,
      createdAt: createdAt,
      image: image,
      isSuperAdmin: isSuperAdmin,
      name: name,
      productsCount: productsCount,
      slug: slug,
      updatedAt: updatedAt,
    );
  }
}

extension MetaDataMapper on MetadataDto {
  MetadataModel toMetaDataModel() {
    return MetadataModel(
      currentPage: currentPage,
      limit: limit,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}
