part of 'product_details_cubit.dart';

class ProductDetailsState {
  final Resource<ProductDetailsEntity> resource;
  final int selectedImageIndex;

  const ProductDetailsState({
    required this.resource,
    required this.selectedImageIndex,
  });

  factory ProductDetailsState.initial() =>
      ProductDetailsState(
        resource: Resource.initial(),
        selectedImageIndex: 0,
      );

  ProductDetailsState copyWith({
    Resource<ProductDetailsEntity>? resource,
    int? selectedImageIndex,
  }) {
    return ProductDetailsState(
      resource: resource ?? this.resource,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
    );
  }
}
