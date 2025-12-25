import 'package:flutter/material.dart';

@immutable
class NavState  {
  final int selectedIndex;
  
  const NavState({required this.selectedIndex});
  
  @override
  List<Object?> get props => [selectedIndex];
}

final class NavInitial extends NavState {
  const NavInitial({required int selectedIndex}) 
      : super(selectedIndex: selectedIndex);
}