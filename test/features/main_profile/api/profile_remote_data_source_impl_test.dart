import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flower_shop/features/main_profile/api/profile_remote_data_source_impl.dart';
import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import '../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl dataSource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockApiClient);
  });

  setUp(() {});

  group("ProfileRemoteDataSourceImpl.getProfile()", () {
    test(
      "returns SuccessApiResult when apiClient returns valid response",
      () async {
        // arrange
        const token = "Bearer test-token";

        final fakeResponse = ProfileResponse(
          message: "success",
          profileUserModel: ProfileUserModel(
            id: "1",
            firstName: "Rahma",
            lastName: "Ahmed",
            email: "rahma@test.com",
          ),
        );

        final dioResponse = Response<ProfileResponse>(
          requestOptions: RequestOptions(path: '/profile'),
          data: fakeResponse,
          statusCode: 200,
        );

        final fakeHttpResponse = HttpResponse<ProfileResponse>(
          dioResponse.data!,
          dioResponse,
        );

        when(
          mockApiClient.getProfileData(token),
        ).thenAnswer((_) async => fakeHttpResponse);

        // act
        final result = await dataSource.getProfile(token);

        // assert
        expect(result, isA<SuccessApiResult<ProfileResponse>>());

        final data = (result as SuccessApiResult).data;
        expect(data.message, "success");
        expect(data.profileUserModel?.firstName, "Rahma");
        expect(data.profileUserModel?.email, "rahma@test.com");

        verify(mockApiClient.getProfileData(token)).called(1);
      },
    );

    test("returns ErrorApiResult when apiClient throws Exception", () async {
      // arrange
      const token = "Bearer test-token";

      when(
        mockApiClient.getProfileData(token),
      ).thenThrow(Exception("network error"));

      // act
      final result = await dataSource.getProfile(token);

      // assert
      expect(result, isA<ErrorApiResult<ProfileResponse>>());
      expect(
        (result as ErrorApiResult).error.toString(),
        contains("network error"),
      );

      verify(mockApiClient.getProfileData(token)).called(1);
    });
  });

  group("ProfileRemoteDataSourceImpl.getAboutData()", () {
    test('should return parsed about_app json file correctly', () async {
      const fakeAboutJson = '''
    {
      "about_app": [
        {
          "section": "title",
          "content": {
            "en": "About Flowery App",
            "ar": "عن تطبيق فلاوري"
          },
          "style": {
            "fontSize": 24,
            "fontWeight": "bold",
            "color": "#D21E6A",
            "textAlign": {
              "en": "center",
              "ar": "center"
            },
            "backgroundColor": "#FFFFFF"
          }
        }
      ]
    }
    ''';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
            final String key = utf8.decode(message!.buffer.asUint8List());
            if (key == 'assets/files/about_section.json') {
              return ByteData.view(utf8.encoder.convert(fakeAboutJson).buffer);
            }
            return null;
          });
      final result = await dataSource.getAboutData();

      expect(result, isA<List<AboutAndTermsDto>>());
      expect(result.isNotEmpty, true);
      expect(result.first.section, 'title');
      expect(result.first.content, isA<Map<String, dynamic>>());
      expect(result.first.content['en'], 'About Flowery App');
      expect(result.first.content['ar'], 'عن تطبيق فلاوري');
    });
  });

  group("ProfileRemoteDataSourceImpl.getTerms()", () {
    test('should parse terms_and_conditions json correctly', () async {
      const fakeTermsJson = '''
    {
      "terms_and_conditions": [
        {
          "section": "title",
          "content": {
            "en": "Terms and Conditions for Flowery App",
            "ar": "الشروط والأحكام لتطبيق فلاوري"
          },
          "style": {
            "fontSize": 24,
            "fontWeight": "bold",
            "color": "#D21E6A",
            "textAlign": {
              "en": "center",
              "ar": "center"
            },
            "backgroundColor": "#FFFFFF"
          }
        },
        {
          "section": "use_of_app",
          "title": {
            "en": "1. Use of the App",
            "ar": "1. استخدام التطبيق"
          },
          "content": {
            "en": [
              "You must be at least 18 years old."
            ],
            "ar": [
              "يجب أن تكون تبلغ من العمر 18 عامًا."
            ]
          },
          "style": {
            "title": {
              "fontSize": 18,
              "fontWeight": "bold",
              "color": "#D21E6A",
              "textAlign": {
                "en": "left",
                "ar": "right"
              },
              "backgroundColor": "#FFFFFF"
            },
            "content": {
              "fontSize": 16,
              "fontWeight": "normal",
              "color": "#333333",
              "textAlign": {
                "en": "left",
                "ar": "right"
              },
              "backgroundColor": "#FFFFFF"
            }
          }
        }
      ]
    }
    ''';

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
            final String key = utf8.decode(message!.buffer.asUint8List());
            if (key == 'assets/files/terms.json') {
              return ByteData.view(utf8.encoder.convert(fakeTermsJson).buffer);
            }
            return null;
          });

      final result = await dataSource.getTerms();

      expect(result, isA<List<AboutAndTermsDto>>());
      expect(result.length, 2);

      final first = result.first;
      expect(first.section, 'title');
      expect(first.content, isA<Map<String, dynamic>>());
      expect(first.content['en'], 'Terms and Conditions for Flowery App');

      final second = result[1];
      expect(second.section, 'use_of_app');
      expect(second.title, isA<Map<String, dynamic>>());
      expect(second.title!['en'], '1. Use of the App');

      expect(second.content, isA<Map<String, dynamic>>());
      expect(second.content['en'], isA<List<dynamic>>());
      expect(
        (second.content['en'] as List).first,
        'You must be at least 18 years old.',
      );
    });
  });

  group("ProfileRemoteDataSourceImpl.getOrders()", () {
    test("should call getUserOrders from apiClient", () async {
      // arrange
      const tToken = "test_token";
      final tOrderResponse = OrderResponse(message: "success", orders: []);

      when(
        mockApiClient.getUserOrders(any),
      ).thenAnswer((_) async => tOrderResponse);

      // act
      final result = await dataSource.getOrders(token: tToken);

      // assert
      expect(result, tOrderResponse);
      verify(mockApiClient.getUserOrders('Bearer $tToken')).called(1);
    });
  });
}
