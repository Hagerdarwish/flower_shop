import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../app/config/base_state/base_state.dart';
import '../../../../../../app/core/network/api_result.dart';
import '../../../../domain/models/product_details_entity.dart';
import '../../../../domain/usecase/get_product_details_usecase.dart';
import 'package:injectable/injectable.dart';

part 'product_details_state.dart';
part 'product_details_intents.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase _useCase;
  final String productId;

  ProductDetailsCubit(this._useCase, @factoryParam this.productId)
    : super(ProductDetailsState.initial()) {
    // Automatically load product details on creation
    doIntent(LoadProductDetailsIntent(productId));
  }

  void doIntent(ProductDetailsIntents intent) {
    switch (intent.runtimeType) {
      case LoadProductDetailsIntent:
        _loadProductDetails(intent as LoadProductDetailsIntent);
        break;
      case ChangeImageIntent:
        _changeImage(intent as ChangeImageIntent);
        break;
      case AddToCartIntent:
        _addToCart();
        break;
    }
  }

  Future<void> _loadProductDetails(LoadProductDetailsIntent intent) async {
    emit(state.copyWith(resource: Resource.loading()));
    final result = await _useCase(intent.productId);

    if (result is SuccessApiResult<ProductDetailsEntity>) {
      emit(state.copyWith(resource: Resource.success(result.data)));
    } else if (result is ErrorApiResult<ProductDetailsEntity>) {
      emit(state.copyWith(resource: Resource.error(result.error)));
    } else {
      emit(state.copyWith(resource: Resource.error('Unexpected error')));
    }
  }

  void _changeImage(ChangeImageIntent intent) {
    emit(state.copyWith(selectedImageIndex: intent.index));
  }

  void _addToCart() {
    final product = state.resource.data;
    if (product != null) {
      print('Add to cart: ${product.title}');
    }
  }
}
