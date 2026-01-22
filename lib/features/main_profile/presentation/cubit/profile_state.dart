import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

class ProfileState {
  final Resource<ProfileUserModel> user;

  ProfileState({required this.user});

  factory ProfileState.initial() {
    return ProfileState(user: Resource.initial());
  }

  ProfileState copyWith({Resource<ProfileUserModel>? user}) {
    return ProfileState(user: user ?? this.user);
  }
}
