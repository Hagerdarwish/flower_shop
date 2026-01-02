// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flower_shop/app/config/base_state/base_state.dart';
// import 'package:flower_shop/app/core/network/api_result.dart';
// import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
// import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
// import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';
// import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
// import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';

// // Mock the use case
// class MockGetBestSellerUseCase extends Mock implements GetBestSellerUseCase {}

// void main() {
//   late BestSellerCubit cubit;
//   late MockGetBestSellerUseCase mockUseCase;

//   setUp(() {
//     mockUseCase = MockGetBestSellerUseCase();
//     cubit = BestSellerCubit(mockUseCase);
//   });

//   final productsList = [
//     BestSellerModel(id: '1', title: 'Product 1', price: 100, imgCover: ''),
//     BestSellerModel(id: '2', title: 'Product 2', price: 200, imgCover: ''),
//   ];

//   group('BestSellerCubit', () {
//     test('initial state is BestSellerState.initial', () {
//       expect(cubit.state.products.status, Status.initial);
//       expect(cubit.state.products.data, null);
//     });

//     blocTest<BestSellerCubit, BestSellerState>(
//       'emits loading then success when usecase returns data',
//       build: () {
//         when(() => mockUseCase()).thenAnswer(
//           () async => SuccessApiResult<List<BestSellerModel>>(productsList),
//         );
//         return BestSellerCubit(mockUseCase);
//       },
//       act: (cubit) => cubit.doIntent(LoadBestSellersEvent()),
//       expect: () => [
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.loading,
//         ),
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.success,
//         ),
//       ],
//       verify: (_) {
//         expect(cubit.state.products.data, productsList);
//         verify(mockUseCase.call()).called(1);
//       },
//     );

//     blocTest<BestSellerCubit, BestSellerState>(
//       'emits loading then error when usecase fails',
//       build: () {
//         when(() => mockUseCase()).thenAnswer(
//           () async => ErrorApiResult<List<BestSellerModel>>('Failed to load'),
//         );
//         return BestSellerCubit(mockUseCase);
//       },
//       act: (cubit) => cubit.doIntent(LoadBestSellersEvent()),
//       expect: () => [
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.loading,
//         ),
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.error,
//         ),
//       ],
//       verify: (_) {
//         expect(cubit.state.products.error, 'Failed to load');
//         verify(mockUseCase.call()).called(1);
//       },
//     );

//     blocTest<BestSellerCubit, BestSellerState>(
//       'emits loading then success with empty list when usecase returns empty',
//       build: () {
//         when(() => mockUseCase()).thenAnswer(
//           () async => SuccessApiResult<List<BestSellerModel>>([]),
//         );
//         return BestSellerCubit(mockUseCase);
//       },
//       act: (cubit) => cubit.doIntent(LoadBestSellersEvent()),
//       expect: () => [
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.loading,
//         ),
//         isA<BestSellerState>().having(
//           (s) => s.products.status,
//           'status',
//           Status.success,
//         ),
//       ],
//       verify: (_) {
//         expect(cubit.state.products.data, []);
//         verify(mockUseCase.call()).called(1);
//       },
//     );
//   });
// }
