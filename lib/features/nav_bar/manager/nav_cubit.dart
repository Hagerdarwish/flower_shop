import 'package:bloc/bloc.dart';
import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial(selectedIndex: 0));

  void updateIndex(int index) {
    // Emit a new instance without creating separate class
    emit(_NavUpdated(selectedIndex: index));
  }
}

// Private class for updated state
class _NavUpdated extends NavState {
  const _NavUpdated({required int selectedIndex}) 
      : super(selectedIndex: selectedIndex);
}