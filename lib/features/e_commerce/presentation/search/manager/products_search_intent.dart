sealed class ProductsSearchIntent {}

class GetProductsByIdIntent extends ProductsSearchIntent {
  String? search;
  GetProductsByIdIntent({this.search});
}
