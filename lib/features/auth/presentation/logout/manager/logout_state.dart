import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';

class LogoutStates {
  final Resource<LogoutResponse> logoutResource;

  LogoutStates({Resource<LogoutResponse>? logoutResource})
    : logoutResource = logoutResource ?? Resource.initial();

  LogoutStates copyWith({Resource<LogoutResponse>? logoutResource}) {
    return LogoutStates(logoutResource: logoutResource ?? this.logoutResource);
  }
}
