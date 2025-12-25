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

import '../../core/api_manger/api_client.dart' as _i890;
import '../../features/auth/api/datasourse/auth_dataSource_imp.dart' as _i509;
import '../../features/auth/data/datasoure/auth_datasource.dart' as _i49;
import '../../features/auth/data/repos/auth_repo_imp.dart' as _i97;
import '../../features/auth/domain/repos/auth_repo.dart' as _i877;
import '../../features/auth/domain/usecase/forgot_password_usecase.dart'
    as _i749;
import '../../features/auth/domain/usecase/reset_password_usecase.dart'
    as _i1029;
import '../../features/auth/domain/usecase/verify_reset_code_usecase.dart'
    as _i827;
import '../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart'
    as _i332;
import '../../features/auth/presentation/reset_password/manager/reset_password_cubit.dart'
    as _i326;
import '../../features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart'
    as _i938;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i49.AuthDatasource>(
      () => _i509.AuthDatasourceImp(gh<_i890.ApiClient>()),
    );
    gh.factory<_i877.AuthRepo>(
      () => _i97.AuthRepoImp(gh<_i49.AuthDatasource>()),
    );
    gh.factory<_i749.ForgotPasswordUseCase>(
      () => _i749.ForgotPasswordUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factory<_i827.VerifyResetCodeUseCase>(
      () => _i827.VerifyResetCodeUseCase(gh<_i877.AuthRepo>()),
    );
    gh.lazySingleton<_i1029.ResetPasswordUseCase>(
      () => _i1029.ResetPasswordUseCase(gh<_i877.AuthRepo>()),
    );
    gh.factoryParam<_i938.VerifyResetCodeCubit, String, dynamic>(
      (email, _) => _i938.VerifyResetCodeCubit(
        gh<_i827.VerifyResetCodeUseCase>(),
        gh<_i749.ForgotPasswordUseCase>(),
        email,
      ),
    );
    gh.factory<_i332.ForgetPasswordCubit>(
      () => _i332.ForgetPasswordCubit(gh<_i749.ForgotPasswordUseCase>()),
    );
    gh.factory<_i326.ResetPasswordCubit>(
      () => _i326.ResetPasswordCubit(gh<_i1029.ResetPasswordUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
