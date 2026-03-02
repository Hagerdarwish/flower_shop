// import 'package:flower_shop/app/config/base_state/base_state.dart';
// import 'package:flower_shop/app/config/di/di.dart';
// import 'package:flower_shop/app/core/router/route_names.dart';
// import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
// import 'package:flower_shop/app/core/widgets/product_item_card.dart';
// import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_cubit.dart';
// import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_intent.dart';
// import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class ProductsSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//           close(context, null);
//         },
//         icon: Padding(
//           padding: const EdgeInsets.all(1.0),
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: AppColors.grey),
//             ),
//             child: Icon(Icons.close_outlined, size: 20, color: AppColors.grey),
//           ),
//         ),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         showResults(context);
//       },
//       icon: Icon(Icons.search, size: 20, color: AppColors.grey),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return buildSuggestions(context);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var cubit = getIt<ProductsSearchCubit>();
//     if (query.isEmpty) {
//       return const Center(child: Text('Start typing to search'));
//     }
//     cubit.doIntent(GetProductsByIdIntent(search: query));

//     return BlocBuilder<ProductsSearchCubit, ProductsSearchStates>(
//       bloc: cubit,
//       builder: (context, state) {
//         final products = state.products;

//         if (products?.status == Status.loading) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.pink),
//           );
//         }

//         if (products?.status == Status.success &&
//             (products?.data?.isEmpty ?? true)) {
//           return const Center(child: Text('No products found'));
//         }

//         if (products?.status == Status.success && products?.data != null) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: GridView.builder(
//               itemCount: products?.data?.length ?? 0,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 17,
//                 childAspectRatio: 0.70,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 final product = products?.data?[index];
//                 return product != null
//                     ? ProductItemCard(
//                         onTap: () {
//                           context.push(
//                             RouteNames.productDetails,
//                             extra: product.id,
//                           );
//                         },
//                         product: product,
//                       )
//                     : const SizedBox.shrink();
//               },
//             ),
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return Theme.of(context).copyWith(
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//          backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),

//       inputDecorationTheme: InputDecorationTheme(
//         hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
//         contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.pink),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//         ),
//       ),
//       textSelectionTheme: const TextSelectionThemeData(
//         cursorColor: AppColors.pink,
//       ),
//     );
//   }
// }
