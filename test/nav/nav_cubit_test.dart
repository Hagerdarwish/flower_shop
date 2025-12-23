import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_cubit.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('NavCubit Tests', () {
    late NavCubit navCubit;

    setUp(() {
      navCubit = NavCubit();
    });

    tearDown(() {
      navCubit.close();
    });

    test('initial state is correct', () {
      expect(navCubit.state, const NavInitial(selectedIndex: 0));
    });

    blocTest<NavCubit, NavState>(
      'emits NavState with index 1 when updateIndex(1) is called',
      build: () => navCubit,
      act: (cubit) => cubit.updateIndex(1),
      expect: () => [
        const NavState(selectedIndex: 1),
      ],
    );

    blocTest<NavCubit, NavState>(
      'emits NavState with index 2 when updateIndex(2) is called',
      build: () => navCubit,
      act: (cubit) => cubit.updateIndex(2),
      expect: () => [
        const NavState(selectedIndex: 2),
      ],
    );

    blocTest<NavCubit, NavState>(
      'emits NavState with index 0 when updateIndex(0) is called from different index',
      build: () => navCubit,
      seed: () => const NavState(selectedIndex: 3),
      act: (cubit) => cubit.updateIndex(0),
      expect: () => [
        const NavState(selectedIndex: 0),
      ],
    );

    blocTest<NavCubit, NavState>(
      'emits multiple states when updateIndex is called multiple times',
      build: () => navCubit,
      act: (cubit) {
        cubit.updateIndex(1);
        cubit.updateIndex(2);
        cubit.updateIndex(3);
      },
      expect: () => [
        const NavState(selectedIndex: 1),
        const NavState(selectedIndex: 2),
        const NavState(selectedIndex: 3),
      ],
    );

    test('state equality works correctly', () {
      const state1 = NavState(selectedIndex: 1);
      const state2 = NavState(selectedIndex: 1);
      const state3 = NavState(selectedIndex: 2);
      
      expect(state1, state2);
      expect(state1, isNot(state3));
    });
  });
}