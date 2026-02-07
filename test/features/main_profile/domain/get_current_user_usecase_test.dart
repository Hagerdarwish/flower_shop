import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';

import 'usecase/get_current_user_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  // Provide dummy so Mockito works with generic types
  provideDummy<ApiResult<ProfileUserModel>>(
    SuccessApiResult(data: ProfileUserModel()),
  );

  late MockProfileRepo mockRepo;
  late GetCurrentUserUsecase usecase;

  setUp(() {
    mockRepo = MockProfileRepo();
    usecase = GetCurrentUserUsecase(mockRepo);
  });

  test('delegates call to ProfileRepo', () async {
    const token = "Bearer token";

    final user = ProfileUserModel(id: "1", firstName: "Rahma");

    when(
      mockRepo.getCurrentUser(token),
    ).thenAnswer((_) async => SuccessApiResult(data: user));

    final result = await usecase(token);

    expect(result, isA<SuccessApiResult<ProfileUserModel>>());
    verify(mockRepo.getCurrentUser(token)).called(1);
  });
}
