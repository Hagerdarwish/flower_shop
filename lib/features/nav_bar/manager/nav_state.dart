import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class NavState extends Equatable {
  final int selectedIndex;
  
  const NavState({required this.selectedIndex});
  
  @override
  List<Object?> get props => [selectedIndex];
}

final class NavInitial extends NavState {
  const NavInitial({required int selectedIndex}) 
      : super(selectedIndex: selectedIndex);
}