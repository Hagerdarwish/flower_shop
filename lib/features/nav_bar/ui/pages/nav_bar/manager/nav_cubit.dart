import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../manager/nav_cubit/nav_state.dart';
import 'nav_state.dart';

@injectable
class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial(selectedIndex: 0));

  void updateIndex(int index) {
    emit(NavState(selectedIndex: index));
  }
}
