sealed class CartIntent {}

class GetAllCartsIntent extends CartIntent {}

class AddProductToCartIntent extends CartIntent {
  final String productId;
  final int quantity;

  AddProductToCartIntent({required this.productId, required this.quantity});
}

class DeleteCartItemIntent extends CartIntent {
  final String cartItemId;

  DeleteCartItemIntent({required this.cartItemId});
}

class UpdateCartItemQuantityIntent extends CartIntent {
  final String cartItemId;
  final int quantity;
  final bool increase;

  UpdateCartItemQuantityIntent({
    required this.cartItemId,
    required this.quantity,
    required this.increase,
  });
}
