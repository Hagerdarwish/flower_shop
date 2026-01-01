import 'package:flower_shop/features/best_seller/domain/product_model.dart';

class FakeProducts {
  static const List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Red Roses Bouquet',
      imageUrl:
          'https://images.unsplash.com/photo-1525310072745-f49212b5ac6d',
      price: 600,
      oldPrice: 800,
      discountPercent: 25,
      isBestSeller: true,
    ),
    ProductModel(
      id: '2',
      name: 'Pink Tulips',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
      price: 450,
      oldPrice: 550,
      discountPercent: 18,
      isBestSeller: true,
    ),
    ProductModel(
      id: '3',
      name: 'White Lilies',
      imageUrl:
          'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
      price: 500,
      isBestSeller: false,
    ),
    ProductModel(
      id: '4',
      name: 'Sunflower Basket',
      imageUrl:
          'https://images.unsplash.com/photo-1501973801540-537f08ccae7b',
      price: 350,
      oldPrice: 420,
      discountPercent: 17,
      isBestSeller: true,
    ),
    ProductModel(
      id: '5',
      name: 'Mixed Spring Flowers',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946',
      price: 700,
      isBestSeller: false,
    ),
  ];
}
