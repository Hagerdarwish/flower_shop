import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';

class ProfileState {
  final Resource<ProfileUserModel>? user;
  final Resource<List<AboutAndTermsModel>>? about;
  final Resource<List<AboutAndTermsModel>>? terms;

  ProfileState({this.user, this.about, this.terms});

  factory ProfileState.initial() {
    return ProfileState(user: Resource.initial());
  }

  ProfileState copyWith({
    Resource<ProfileUserModel>? user,
    final Resource<List<AboutAndTermsModel>>? about,
    final Resource<List<AboutAndTermsModel>>? terms,
  }) {
    return ProfileState(
      user: user ?? this.user,
      about: about ?? this.about,
      terms: terms ?? this.terms,
    );
  }
}
