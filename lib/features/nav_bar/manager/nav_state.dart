part of 'nav_cubit.dart';

@immutable
 class NavState {
  final int selectedIndex;
  const NavState({required this.selectedIndex });
}

final class NavInitial extends NavState {
  const NavInitial({required int selectedIndex}) : super(selectedIndex: selectedIndex);  
}