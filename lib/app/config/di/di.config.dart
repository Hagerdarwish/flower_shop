// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/auth/api/datasource/auth_remote_datasource_impl.dart'
    as _i777;
import '../../../features/auth/data/datasource/auth_remote_datasource.dart'
    as _i708;
import '../../../features/auth/data/repos/auth_repo_imp.dart' as _i866;
import '../../../features/auth/domain/repos/auth_repo.dart' as _i712;
import '../../../features/auth/domain/usecase/forgot_password_usecase.dart'
    as _i878;
import '../../../features/auth/domain/usecase/login_usecase.dart' as _i75;
import '../../../features/auth/domain/usecase/reset_password_usecase.dart'
    as _i280;
import '../../../features/auth/domain/usecase/signup_usecase.dart' as _i543;
import '../../../features/auth/domain/usecase/verify_reset_code_usecase.dart'
    as _i967;
import '../../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart'
    as _i702;
import '../../../features/auth/presentation/login/manager/login_cubit.dart'
    as _i810;
import '../../../features/auth/presentation/reset_password/manager/reset_password_cubit.dart'
    as _i378;
import '../../../features/auth/presentation/signup/manager/signup_cubit.dart'
    as _i392;
import '../../../features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart'
    as _i303;
import '../../core/api_manger/api_client.dart' as _i890;
import '../auth_storage/auth_storage.dart' as _i603;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i603.AuthStorage>(() => _i603.AuthStorage());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i708.AuthRemoteDataSource>(
      () => _i777.AuthRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i712.AuthRepo>(
      () => _i866.AuthRepoImp(gh<_i708.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i280.ResetPasswordUseCase>(
      () => _i280.ResetPasswordUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i878.ForgotPasswordUseCase>(
      () => _i878.ForgotPasswordUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i967.VerifyResetCodeUseCase>(
      () => _i967.VerifyResetCodeUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i702.ForgetPasswordCubit>(
      () => _i702.ForgetPasswordCubit(gh<_i878.ForgotPasswordUseCase>()),
    );
    gh.factoryParam<_i303.VerifyResetCodeCubit, String, dynamic>(
      (email, _) => _i303.VerifyResetCodeCubit(
        gh<_i967.VerifyResetCodeUseCase>(),
        gh<_i878.ForgotPasswordUseCase>(),
        email,
      ),
    );
    gh.factory<_i543.SignupUsecase>(
      () => _i543.SignupUsecase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i75.LoginUseCase>(
      () => _i75.LoginUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i378.ResetPasswordCubit>(
      () => _i378.ResetPasswordCubit(gh<_i280.ResetPasswordUseCase>()),
    );
    gh.factory<_i392.AuthCubit>(
      () => _i392.AuthCubit(gh<_i543.SignupUsecase>()),
    );
    gh.factory<_i810.LoginCubit>(
      () => _i810.LoginCubit(gh<_i75.LoginUseCase>(), gh<_i603.AuthStorage>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
