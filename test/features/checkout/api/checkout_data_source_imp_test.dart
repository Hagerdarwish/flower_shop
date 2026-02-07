import 'package:dio/dio.dart';
import 'package:flower_shop/features/checkout/api/checkout_data_source_imp.dart';
import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';

import '../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late CheckoutDataSourceImp dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = CheckoutDataSourceImp(mockApiClient);
  });

  group("CheckoutDataSourceImp.cashOrder()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        // arrange
        const token = "Bearer test-token";

        // create fake product
        final fakeProduct = Product(
          id: '1',
          title: 'product_1',
          description: 'desc_1',
          imgCover: 'https://fakeimage.com/img.png',
          price: 20,
          priceAfterDiscount: 10,
          quantity: 1,
          category: 'category_1',
          slug: '',
          createdAt: DateTime(2000),
          updatedAt: DateTime(2000),
          images: [],
          occasion: '',
          rateAvg: 1,
          rateCount: 1,
          v: 1,
          productId: '1',
          sold: 1,
          isSuperAdmin: true,
        );

        // create fake order item
        final fakeItem = OrderItem(
          id: "item_1",
          quantity: 1,
          price: 100,
          product: fakeProduct,
        );

        // create fake order
        final fakeOrder = Order(
          id: "order_1",
          paymentType: "cash",
          isPaid: false,
          isDelivered: false,
          state: "pending",
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 1),
          orderNumber: "ORD-001",
          totalPrice: 100,
          user: 'user_1',
          v: 1,
          orderItems: [fakeItem], // ✅ use a list here
        );

        // create fake response
        final fakeResponse = CashOrderResponse(
          message: "order created successfully",
          order: fakeOrder,
        );

        final dioResponse = Response<CashOrderResponse>(
          requestOptions: RequestOptions(path: '/cash-order'),
          data: fakeResponse,
          statusCode: 200,
        );

        final fakeHttpResponse = HttpResponse<CashOrderResponse>(
          dioResponse.data!,
          dioResponse,
        );

        when(
          mockApiClient.cashOrder(token),
        ).thenAnswer((_) async => fakeHttpResponse);

        // act
        final result = await dataSource.cashOrder(token);

        // assert
        expect(result, isA<SuccessApiResult<CashOrderResponse>>());
        final data = (result as SuccessApiResult).data;
        expect(data.message, "order created successfully");
        expect(data.order.id, "order_1");
        expect(data.order.orderItems.first.product.title, 'product_1');

        verify(mockApiClient.cashOrder(token)).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // arrange
      const token = "Bearer test-token";

      when(
        mockApiClient.cashOrder(token),
      ).thenThrow(Exception("network error"));

      // act
      final result = await dataSource.cashOrder(token);

      // assert
      expect(result, isA<ErrorApiResult<CashOrderResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );

      verify(mockApiClient.cashOrder(token)).called(1);
    });
  });

  group("CheckoutDataSourceImp.getAddress()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        // arrange
        const token = "Bearer test-token";

        final fakeResponse = AddressCheckOutResponse(
          message: "address fetched successfully",
          addresses: [],
        );

        final dioResponse = Response<AddressCheckOutResponse>(
          requestOptions: RequestOptions(path: '/address'),
          data: fakeResponse,
          statusCode: 200,
        );

        final fakeHttpResponse = HttpResponse<AddressCheckOutResponse>(
          dioResponse.data!,
          dioResponse,
        );

        when(
          mockApiClient.address(token),
        ).thenAnswer((_) async => fakeHttpResponse);

        // act
        final result = await dataSource.getAddress(token);

        // assert
        expect(result, isA<SuccessApiResult<AddressCheckOutResponse>>());
        final data = (result as SuccessApiResult).data;
        expect(data.message, "address fetched successfully");

        verify(mockApiClient.address(token)).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // arrange
      const token = "Bearer test-token";

      when(mockApiClient.address(token)).thenThrow(Exception("network error"));

      // act
      final result = await dataSource.getAddress(token);

      // assert
      expect(result, isA<ErrorApiResult<AddressCheckOutResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );

      verify(mockApiClient.address(token)).called(1);
    });
  });
}
