part of 'product_details_cubit.dart';

sealed class ProductDetailsIntents {
  const ProductDetailsIntents();
}

class LoadProductDetailsIntent extends ProductDetailsIntents {
  final String productId;
  const LoadProductDetailsIntent(this.productId);
}

class ChangeImageIntent extends ProductDetailsIntents {
  final int index;
  const ChangeImageIntent(this.index);
}

class AddToCartIntent extends ProductDetailsIntents {
  const AddToCartIntent();
}
