import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial(selectedIndex: 0));

  void updateIndex(int index) {
    emit(NavState(selectedIndex: index));
  }
}
