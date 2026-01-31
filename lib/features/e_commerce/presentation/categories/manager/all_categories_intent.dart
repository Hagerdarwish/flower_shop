sealed class AllCategoriesIntent {}

class GetAllCategoriesEvent extends AllCategoriesIntent {}

class SelectCategoryEvent extends AllCategoriesIntent {
  int selectedIndex;
  SelectCategoryEvent({this.selectedIndex = 0});
}

sealed class EcommerceUiEvents {}

class OnSearchTapEvent extends EcommerceUiEvents {}
