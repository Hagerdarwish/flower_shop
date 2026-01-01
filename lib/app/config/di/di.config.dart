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

import '../../../features/app_start/presentation/manager/app_cubit.dart'
    as _i858;
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
import '../../../features/commerce/api/datasource/commerce_remote_datasource_impl.dart'
    as _i574;
import '../../../features/commerce/data/datasource/commerce_remote_datasource.dart'
    as _i97;
import '../../../features/commerce/data/repos/commerce_repo_impl.dart' as _i200;
import '../../../features/commerce/domain/repos/commerce_repo.dart' as _i796;
import '../../../features/commerce/domain/usecase/all_categories_usecase.dart'
    as _i177;
import '../../../features/commerce/presentation/categories/manager/all_categories_cubit.dart'
    as _i707;
import '../../../features/home/api/home_remote_data_source_imp.dart' as _i874;
import '../../../features/home/data/datasource/home_remote_data_source.dart'
    as _i701;
import '../../../features/home/data/repos/home_repo_imp.dart' as _i401;
import '../../../features/home/domain/repos/home_repo.dart' as _i520;
import '../../../features/home/domain/usecase/get_best_seller_usecase.dart'
    as _i534;
import '../../../features/home/domain/usecase/get_categories_usecase.dart'
    as _i576;
import '../../../features/home/domain/usecase/get_occasions_usecase.dart'
    as _i386;
import '../../../features/home/domain/usecase/get_products_usecase.dart'
    as _i498;
import '../../../features/home/presentation/manager/factory/home_factory.dart'
    as _i94;
import '../../../features/home/presentation/manager/factory/home_factory_imp.dart'
    as _i73;
import '../../../features/home/presentation/manager/home_cubit.dart' as _i682;
import '../../../features/nav_bar/api/datasource/product_details_datasource_imp.dart'
    as _i749;
import '../../../features/nav_bar/data/datasource/home_remote_datasouce/home_remote_datasource.dart'
    as _i662;
import '../../../features/nav_bar/data/datasource/home_remote_datasouce/home_remote_datasource_impl.dart'
    as _i105;
import '../../../features/nav_bar/data/product_details/datasource/product_details_remote_datasource.dart'
    as _i555;
import '../../../features/nav_bar/data/product_details/repos/product_details_repo_imp.dart'
    as _i737;
import '../../../features/nav_bar/data/repos/home_repo_imp.dart' as _i255;
import '../../../features/nav_bar/domain/product_details/repos/product_details_repo.dart'
    as _i618;
import '../../../features/nav_bar/domain/product_details/usecase/get_product_details_usecase.dart'
    as _i1056;
import '../../../features/nav_bar/domain/repos/home_repo.dart' as _i864;
import '../../../features/nav_bar/domain/usecase/get_product_usecase.dart'
    as _i329;
import '../../../features/nav_bar/manager/nav_cubit/nav_cubit.dart' as _i235;
import '../../../features/nav_bar/presentation/manger/product_details_cubit/product_details_cubit.dart'
    as _i634;
import '../../../features/nav_bar/ui/pages/nav_bar/manager/nav_cubit.dart'
    as _i355;
import '../../../features/nav_bar/ui/pages/occasion/manager/occasion_cubit.dart'
    as _i652;
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
    gh.factory<_i235.NavCubit>(() => _i235.NavCubit());
    gh.factory<_i355.NavCubit>(() => _i355.NavCubit());
    gh.lazySingleton<_i603.AuthStorage>(() => _i603.AuthStorage());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i708.AuthRemoteDataSource>(
      () => _i777.AuthRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i701.HomeRemoteDataSource>(
      () => _i874.HomeRemoteDataSourceImp(gh<_i890.ApiClient>()),
    );
    gh.factory<_i858.AppCubit>(() => _i858.AppCubit(gh<_i603.AuthStorage>()));
    gh.factory<_i712.AuthRepo>(
      () => _i866.AuthRepoImp(gh<_i708.AuthRemoteDataSource>()),
    );
    gh.factory<_i520.HomeRepo>(
      () => _i401.HomeRepoImp(gh<_i701.HomeRemoteDataSource>()),
    );
    gh.factory<_i662.HomeRemoteDatasource>(
      () => _i105.HomeRemoteDatasourceImpl(gh<_i890.ApiClient>()),
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
    gh.factory<_i97.CommerceRemoteDatasource>(
      () => _i574.CommerceRemoteDatasourceImpl(gh<_i890.ApiClient>()),
    );
    gh.lazySingleton<_i555.ProductDetailsRemoteDataSource>(
      () => _i749.ProductDetailsRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i543.SignupUsecase>(
      () => _i543.SignupUsecase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i75.LoginUseCase>(
      () => _i75.LoginUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i796.CommerceRepo>(
      () => _i200.CommerceRepoImpl(gh<_i97.CommerceRemoteDatasource>()),
    );
    gh.lazySingleton<_i618.ProductDetailsRepo>(
      () => _i737.ProductDetailsRepoImpl(
        gh<_i555.ProductDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i392.AuthCubit>(
      () => _i392.AuthCubit(gh<_i543.SignupUsecase>()),
    );
    gh.factoryParam<_i378.ResetPasswordCubit, String, dynamic>(
      (email, _) =>
          _i378.ResetPasswordCubit(email, gh<_i280.ResetPasswordUseCase>()),
    );
    gh.factory<_i534.GetBestSellerUseCase>(
      () => _i534.GetBestSellerUseCase(gh<_i520.HomeRepo>()),
    );
    gh.factory<_i576.GetCategoriesUseCase>(
      () => _i576.GetCategoriesUseCase(gh<_i520.HomeRepo>()),
    );
    gh.factory<_i386.GetOccasionsUseCase>(
      () => _i386.GetOccasionsUseCase(gh<_i520.HomeRepo>()),
    );
    gh.factory<_i498.GetProductsUseCase>(
      () => _i498.GetProductsUseCase(gh<_i520.HomeRepo>()),
    );
    gh.lazySingleton<_i94.HomeFactory>(
      () => _i73.RemoteHomeFactory(
        gh<_i498.GetProductsUseCase>(),
        gh<_i576.GetCategoriesUseCase>(),
        gh<_i534.GetBestSellerUseCase>(),
        gh<_i386.GetOccasionsUseCase>(),
      ),
    );
    gh.factory<_i864.HomeRepo>(
      () => _i255.HomeRepoImp(gh<_i662.HomeRemoteDatasource>()),
    );
    gh.factory<_i329.GetProductUsecase>(
      () => _i329.GetProductUsecase(gh<_i864.HomeRepo>()),
    );
    gh.lazySingleton<_i1056.GetProductDetailsUseCase>(
      () => _i1056.GetProductDetailsUseCase(gh<_i618.ProductDetailsRepo>()),
    );
    gh.factory<_i810.LoginCubit>(
      () => _i810.LoginCubit(gh<_i75.LoginUseCase>(), gh<_i603.AuthStorage>()),
    );
    gh.factory<_i177.AllCategoriesUsecase>(
      () => _i177.AllCategoriesUsecase(gh<_i796.CommerceRepo>()),
    );
    gh.factoryParam<_i634.ProductDetailsCubit, String, dynamic>(
      (productId, _) => _i634.ProductDetailsCubit(
        gh<_i1056.GetProductDetailsUseCase>(),
        productId,
      ),
    );
    gh.factory<_i682.HomeCubit>(() => _i682.HomeCubit(gh<_i94.HomeFactory>()));
    gh.factory<_i652.OccasionCubit>(
      () => _i652.OccasionCubit(gh<_i329.GetProductUsecase>()),
    );
    gh.factory<_i707.AllCategoriesCubit>(
      () => _i707.AllCategoriesCubit(
        gh<_i177.AllCategoriesUsecase>(),
        gh<_i329.GetProductUsecase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
