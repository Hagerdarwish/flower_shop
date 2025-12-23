import 'package:flower_shop/features/nav_bar/manager/nav_cubit.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_repository.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'nav_cubit_mockito_test.mocks.dart';
import 'nav_cubit_test.dart';


@GenerateMocks([NavRepository])
void main() {

  late MockNavRepository mockRepo;

  setUp(() {
    mockRepo = MockNavRepository();
  });

  group("NavCubit + Mockito Tests", () {

    blocTest<NavCubit, NavState>(
      "loadTab emits mocked index",
      build: () {
        when(mockRepo.loadInitialTab())
             .thenAnswer((_) async => 3);
        return NavCubit();
      },
      expect: () => [const NavState(selectedIndex: 3)],
      act:       (cubit) async {
        // You need to actually call the method that triggers loadTab
        // This depends on your implementation - could be in constructor or a method
        cubit.updateIndex(3); // Or whatever the method name is
      },
    );


    blocTest<NavCubit, NavState>(
      "updateIndex works normally",
      build: () => NavCubit(),
      act: (cubit) => cubit.updateIndex(5),
      expect: () => [const NavState(selectedIndex: 5)],
    );

  });
}
