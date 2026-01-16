// import 'package:flower_shop/app/core/network/api_result.dart';
// import 'package:flower_shop/features/auth/data/models/request/change-password-request-models/change-password-request-model.dart';
// import 'package:flower_shop/features/auth/domain/models/change_password_entity.dart';
// import 'package:flower_shop/features/auth/domain/repos/auth_repo.dart';
// import 'package:flower_shop/features/auth/domain/usecase/change_password_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'auth_usecase_test.mocks.dart';
//
// @GenerateMocks([AuthRepo])
// void main() {
//   late MockAuthRepo mockRepo;
//   late ChangePasswordUseCase useCase;
//
//   setUp(() {
//     mockRepo = MockAuthRepo();
//     useCase = ChangePasswordUseCase(mockRepo);
//   });
//
//   final request = ChangePasswordRequest(
//     password: "Marium@123",
//     newPassword: "Marium@123",
//   );
//
//   group("ChangePasswordUseCase", () {
//     test("returns SuccessApiResult when repo returns success", () async {
//       // ARRANGE
//       final entity = ChangePasswordEntity(
//         message: "success",
//         token: "newToken123",
//       );
//       when(
//         mockRepo.changePassword(any),
//       ).thenAnswer((_) async => SuccessApiResult(data: entity));
//
//       // ACT
//       final result = await useCase.call(request);
//
//       // ASSERT
//       expect(result, isA<SuccessApiResult<ChangePasswordEntity>>());
//       final data = (result as SuccessApiResult).data;
//       expect(data.message, "success");
//       expect(data.token, "newToken123");
//       verify(mockRepo.changePassword(any)).called(1);
//     });
//
//     test("returns ErrorApiResult when repo returns error", () async {
//       // ARRANGE
//       when(
//         mockRepo.changePassword(any),
//       ).thenAnswer((_) async => ErrorApiResult(error: "network error"));
//
//       // ACT
//       final result = await useCase.call(request);
//
//       // ASSERT
//       expect(result, isA<ErrorApiResult<ChangePasswordEntity>>());
//       expect((result as ErrorApiResult).error, "network error");
//       verify(mockRepo.changePassword(any)).called(1);
//     });
//   });
// }
