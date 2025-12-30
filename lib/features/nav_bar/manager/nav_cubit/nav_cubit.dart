import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_cubit/nav_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial(selectedIndex: 0));

  void updateIndex(int index) {
    emit(NavState(selectedIndex: index));
  }
}
