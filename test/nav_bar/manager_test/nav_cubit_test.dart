import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/nav_bar/manager/nav_cubit.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/nav_bar/manager/nav_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavCubit', () {
    test('initial state is NavInitial with index 0', () {
      final cubit = NavCubit();
      expect(cubit.state, const NavInitial(selectedIndex: 0));
      cubit.close();
    });

    blocTest<NavCubit, NavState>(
      'emits index 1 when updateIndex(1) is called',
      build: () => NavCubit(),
      act: (cubit) => cubit.updateIndex(1),
      expect: () => [const NavState(selectedIndex: 1)],
    );

    blocTest<NavCubit, NavState>(
      'emits index 2 when updateIndex(2) is called',
      build: () => NavCubit(),
      act: (cubit) => cubit.updateIndex(2),
      expect: () => [const NavState(selectedIndex: 2)],
    );
    blocTest<NavCubit, NavState>(
      'emits index 3 when updateIndex(3) is called',
      build: () => NavCubit(),
      act: (cubit) => cubit.updateIndex(3),
      expect: () => [const NavState(selectedIndex: 3)],
    );

    blocTest<NavCubit, NavState>(
      'does not emit when updating with the same index',
      build: () => NavCubit(),
      seed: () => const NavState(selectedIndex: 3),
      act: (cubit) => cubit.updateIndex(3),
      expect: () => [],
    );

    blocTest<NavCubit, NavState>(
      'emits correct states when updateIndex is called multiple times',
      build: () => NavCubit(),
      act: (cubit) {
        cubit.updateIndex(0);
        cubit.updateIndex(1);
        cubit.updateIndex(2);
        cubit.updateIndex(3);
      },
      expect: () => const [
        NavState(selectedIndex: 0),
        NavState(selectedIndex: 1),
        NavState(selectedIndex: 2),
        NavState(selectedIndex: 3),
      ],
    );

    test('NavState equality works correctly', () {
      const a = NavState(selectedIndex: 0);
      const b = NavState(selectedIndex: 1);
      const c = NavState(selectedIndex: 1);
      const d = NavState(selectedIndex: 2);
      const f = NavState(selectedIndex: 3);

      expect(b, equals(c));
      expect(a, isNot(c));
      expect(d, isNot(c));
      expect(f, isNot(a));
    });
  });
}
