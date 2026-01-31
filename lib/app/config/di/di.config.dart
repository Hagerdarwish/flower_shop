// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
import '../../../features/auth/domain/usecase/change_password_usecase.dart'
    as _i991;
import '../../../features/auth/domain/usecase/forgot_password_usecase.dart'
    as _i878;
import '../../../features/auth/domain/usecase/login_usecase.dart' as _i75;
import '../../../features/auth/domain/usecase/logout_usecase.dart' as _i27;
import '../../../features/auth/domain/usecase/reset_password_usecase.dart'
    as _i280;
import '../../../features/auth/domain/usecase/signup_usecase.dart' as _i543;
import '../../../features/auth/domain/usecase/verify_reset_code_usecase.dart'
    as _i967;
import '../../../features/auth/presentation/change_password/manager/change_password_cubit.dart'
    as _i115;
import '../../../features/auth/presentation/forget_password/manager/forget_password_cubit.dart'
    as _i702;
import '../../../features/auth/presentation/login/manager/login_cubit.dart'
    as _i810;
import '../../../features/auth/presentation/logout/manager/logout_cubit.dart'
    as _i1023;
import '../../../features/auth/presentation/reset_password/manager/reset_password_cubit.dart'
    as _i378;
import '../../../features/auth/presentation/signup/manager/signup_cubit.dart'
    as _i392;
import '../../../features/auth/presentation/verify_reset_code/manager/verify_reset_code_cubit.dart'
    as _i303;
import '../../../features/best_seller/menager/best_sell_cubit.dart' as _i627;
import '../../../features/checkout/api/checkout_data_source_imp.dart' as _i801;
import '../../../features/checkout/data/datasource/checkout_data_source.dart'
    as _i673;
import '../../../features/checkout/data/repos/checkout_repo_imp.dart' as _i178;
import '../../../features/checkout/domain/repos/checkout_repo.dart' as _i14;
import '../../../features/checkout/domain/usecases/get_addresss_usecase.dart'
    as _i872;
import '../../../features/checkout/domain/usecases/post_cashe_order_usecase.dart'
    as _i524;
import '../../../features/checkout/presentation/cubit/checkout_cubit.dart'
    as _i90;
import '../../../features/e_commerce/data/datasource/ecommerce_remote_datasource.dart'
    as _i152;
import '../../../features/e_commerce/data/datasource/ecommerce_remote_datasource_impl.dart'
    as _i396;
import '../../../features/e_commerce/data/repos/ecommerce_repo_imp.dart'
    as _i670;
import '../../../features/e_commerce/domain/repos/ecommerce_repo.dart' as _i332;
import '../../../features/e_commerce/domain/usecase/all_categories_usecase.dart'
    as _i710;
import '../../../features/e_commerce/domain/usecase/get_product_details_usecase.dart'
    as _i129;
import '../../../features/e_commerce/domain/usecase/get_product_usecase.dart'
    as _i985;
import '../../../features/e_commerce/presentation/categories/manager/all_categories_cubit.dart'
    as _i259;
import '../../../features/e_commerce/presentation/occasion/manager/occasion_cubit.dart'
    as _i25;
import '../../../features/e_commerce/presentation/product%20details/manger/product_details_cubit/product_details_cubit.dart'
    as _i50;
import '../../../features/e_commerce/presentation/search/manager/products_search_cubit.dart'
    as _i499;
import '../../../features/edit_profile/api/datasources/edit_profile_datasource_imp.dart'
    as _i857;
import '../../../features/edit_profile/data/datasources/edit_profile_datasource.dart'
    as _i986;
import '../../../features/edit_profile/data/repos/edit_profile_repo_impl.dart'
    as _i202;
import '../../../features/edit_profile/domain/repos/edit_profile_repo.dart'
    as _i485;
import '../../../features/edit_profile/domain/usecases/edit_profile_usecase.dart'
    as _i276;
import '../../../features/edit_profile/domain/usecases/upload_photo_usecase.dart'
    as _i1;
import '../../../features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_cubit.dart'
    as _i924;
import '../../../features/edit_profile/presentation/manager/editProfileCubit/edit_profile_cubit.dart'
    as _i127;
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
import '../../../features/main_profile/api/profile_remote_data_source_impl.dart'
    as _i381;
import '../../../features/main_profile/data/datasource/profile_remote_data_source.dart'
    as _i955;
import '../../../features/main_profile/data/repos/profile_repo_impl.dart'
    as _i562;
import '../../../features/main_profile/domain/repos/profile_repo.dart' as _i866;
import '../../../features/main_profile/domain/usecase/get_about_section_usecase.dart'
    as _i169;
import '../../../features/main_profile/domain/usecase/get_current_user_usecase.dart'
    as _i285;
import '../../../features/main_profile/domain/usecase/get_terms_section_usecase.dart'
    as _i137;
import '../../../features/main_profile/presentation/cubit/profile_cubit.dart'
    as _i650;
import '../../../features/nav_bar/presentation/manager/nav_cubit.dart' as _i405;
import '../../../features/orders/api/datasource/orders_remote_datasource_impl.dart'
    as _i862;
import '../../../features/orders/data/datasource/orders_remote_datasource.dart'
    as _i646;
import '../../../features/orders/data/repos/orders_repo_impl.dart' as _i895;
import '../../../features/orders/domain/repos/orders_repo.dart' as _i867;
import '../../../features/orders/domain/usecase/add_product_to_cart_usecase.dart'
    as _i622;
import '../../../features/orders/domain/usecase/delete_cart_item_usecase.dart'
    as _i153;
import '../../../features/orders/domain/usecase/get_user_carts_usecase.dart'
    as _i444;
import '../../../features/orders/domain/usecase/payment_usecase.dart' as _i985;
import '../../../features/orders/domain/usecase/update_cart_item_quantity_usecase.dart'
    as _i323;
import '../../../features/orders/presentation/manager/cart_cubit.dart' as _i148;
import '../../../features/orders/presentation/manager/paymentcubit/payment_cubit.dart'
    as _i402;
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
    gh.factory<_i405.NavCubit>(() => _i405.NavCubit());
    gh.lazySingleton<_i603.AuthStorage>(() => _i603.AuthStorage());
    gh.factory<_i858.AppCubit>(() => _i858.AppCubit(gh<_i603.AuthStorage>()));
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i603.AuthStorage>()),
    );
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i708.AuthRemoteDataSource>(
      () => _i777.AuthRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i646.OrdersRemoteDatasource>(
      () => _i862.OrdersRemoteDatasourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i673.CheckoutDataSource>(
      () => _i801.CheckoutDataSourceImp(gh<_i890.ApiClient>()),
    );
    gh.factory<_i701.HomeRemoteDataSource>(
      () => _i874.HomeRemoteDataSourceImp(gh<_i890.ApiClient>()),
    );
    gh.factory<_i14.CheckoutRepo>(
      () => _i178.CheckoutRepoImpl(
        checkoutDataSource: gh<_i673.CheckoutDataSource>(),
      ),
    );
    gh.factory<_i712.AuthRepo>(
      () => _i866.AuthRepoImp(gh<_i708.AuthRemoteDataSource>()),
    );
    gh.factory<_i520.HomeRepo>(
      () => _i401.HomeRepoImp(gh<_i701.HomeRemoteDataSource>()),
    );
    gh.factory<_i867.OrdersRepo>(
      () => _i895.OrdersRepoImpl(gh<_i646.OrdersRemoteDatasource>()),
    );
    gh.factory<_i152.EcommerceRemoteDatasource>(
      () => _i396.EcommerceRemoteDatasourceImpl(gh<_i890.ApiClient>()),
    );
    gh.lazySingleton<_i991.ChangePasswordUseCase>(
      () => _i991.ChangePasswordUseCase(gh<_i712.AuthRepo>()),
    );
    gh.lazySingleton<_i280.ChangePasswordUseCase>(
      () => _i280.ChangePasswordUseCase(gh<_i712.AuthRepo>()),
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
    gh.factory<_i986.EditProfileDataSource>(
      () => _i857.EditprofiledatascourceImp(gh<_i890.ApiClient>()),
    );
    gh.factoryParam<_i303.VerifyResetCodeCubit, String, dynamic>(
      (email, _) => _i303.VerifyResetCodeCubit(
        gh<_i967.VerifyResetCodeUseCase>(),
        gh<_i878.ForgotPasswordUseCase>(),
        email,
      ),
    );
    gh.factory<_i955.ProfileremoteDataSource>(
      () => _i381.ProfileRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i872.GetAddressUsecase>(
      () => _i872.GetAddressUsecase(gh<_i14.CheckoutRepo>()),
    );
    gh.factory<_i524.PostCasheOrderUsecase>(
      () => _i524.PostCasheOrderUsecase(gh<_i14.CheckoutRepo>()),
    );
    gh.factory<_i543.SignupUsecase>(
      () => _i543.SignupUsecase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i75.LoginUseCase>(
      () => _i75.LoginUseCase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i27.LogoutUsecase>(
      () => _i27.LogoutUsecase(gh<_i712.AuthRepo>()),
    );
    gh.factory<_i485.EditprofileRepo>(
      () => _i202.EditprofileRepoImpl(gh<_i986.EditProfileDataSource>()),
    );
    gh.factory<_i332.EcommerceRepo>(
      () => _i670.EcommerceRepoImp(gh<_i152.EcommerceRemoteDatasource>()),
    );
    gh.factoryParam<_i378.ResetPasswordCubit, String, dynamic>(
      (email, _) =>
          _i378.ResetPasswordCubit(email, gh<_i280.ChangePasswordUseCase>()),
    );
    gh.factory<_i115.ChangePasswordCubit>(
      () => _i115.ChangePasswordCubit(gh<_i991.ChangePasswordUseCase>()),
    );
    gh.factory<_i392.AuthCubit>(
      () => _i392.AuthCubit(gh<_i543.SignupUsecase>()),
    );
    gh.factory<_i90.CheckoutCubit>(
      () => _i90.CheckoutCubit(
        gh<_i524.PostCasheOrderUsecase>(),
        gh<_i872.GetAddressUsecase>(),
        gh<_i603.AuthStorage>(),
      ),
    );
    gh.factory<_i276.EditProfileUseCase>(
      () => _i276.EditProfileUseCase(gh<_i485.EditprofileRepo>()),
    );
    gh.factory<_i1.UploadPhotoUseCase>(
      () => _i1.UploadPhotoUseCase(gh<_i485.EditprofileRepo>()),
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
    gh.factory<_i1023.LogoutCubit>(
      () =>
          _i1023.LogoutCubit(gh<_i27.LogoutUsecase>(), gh<_i603.AuthStorage>()),
    );
    gh.factory<_i710.AllCategoriesUsecase>(
      () => _i710.AllCategoriesUsecase(gh<_i332.EcommerceRepo>()),
    );
    gh.factory<_i127.EditProfileCubit>(
      () => _i127.EditProfileCubit(
        gh<_i276.EditProfileUseCase>(),
        gh<_i603.AuthStorage>(),
      ),
    );
    gh.factory<_i622.AddProductToCartUsecase>(
      () => _i622.AddProductToCartUsecase(gh<_i867.OrdersRepo>()),
    );
    gh.factory<_i153.DeleteCartItemUsecase>(
      () => _i153.DeleteCartItemUsecase(gh<_i867.OrdersRepo>()),
    );
    gh.factory<_i444.GetUserCartsUsecase>(
      () => _i444.GetUserCartsUsecase(gh<_i867.OrdersRepo>()),
    );
    gh.factory<_i985.PaymentUsecase>(
      () => _i985.PaymentUsecase(gh<_i867.OrdersRepo>()),
    );
    gh.factory<_i323.UpdateCartItemQuantityUsecase>(
      () => _i323.UpdateCartItemQuantityUsecase(gh<_i867.OrdersRepo>()),
    );
    gh.factory<_i866.ProfileRepo>(
      () => _i562.ProfileRepoImpl(
        profileRemoteDataSource: gh<_i955.ProfileremoteDataSource>(),
      ),
    );
    gh.factory<_i810.LoginCubit>(
      () => _i810.LoginCubit(gh<_i75.LoginUseCase>(), gh<_i603.AuthStorage>()),
    );
    gh.factory<_i985.GetProductUsecase>(
      () => _i985.GetProductUsecase(gh<_i332.EcommerceRepo>()),
    );
    gh.lazySingleton<_i129.GetProductDetailsUseCase>(
      () => _i129.GetProductDetailsUseCase(gh<_i332.EcommerceRepo>()),
    );
    gh.factory<_i402.PaymentCubit>(
      () => _i402.PaymentCubit(
        gh<_i985.PaymentUsecase>(),
        gh<_i603.AuthStorage>(),
      ),
    );
    gh.factory<_i627.BestSellerCubit>(
      () => _i627.BestSellerCubit(gh<_i534.GetBestSellerUseCase>()),
    );
    gh.factory<_i169.GetAboutSectionUsecase>(
      () => _i169.GetAboutSectionUsecase(gh<_i866.ProfileRepo>()),
    );
    gh.factory<_i137.GetTermsSectionUsecase>(
      () => _i137.GetTermsSectionUsecase(gh<_i866.ProfileRepo>()),
    );
    gh.factoryParam<_i50.ProductDetailsCubit, String, dynamic>(
      (productId, _) => _i50.ProductDetailsCubit(
        gh<_i129.GetProductDetailsUseCase>(),
        productId,
      ),
    );
    gh.factory<_i924.UploadPhotoCubit>(
      () => _i924.UploadPhotoCubit(
        gh<_i1.UploadPhotoUseCase>(),
        gh<_i603.AuthStorage>(),
      ),
    );
    gh.singleton<_i148.CartCubit>(
      () => _i148.CartCubit(
        gh<_i444.GetUserCartsUsecase>(),
        gh<_i622.AddProductToCartUsecase>(),
        gh<_i153.DeleteCartItemUsecase>(),
        gh<_i323.UpdateCartItemQuantityUsecase>(),
      ),
    );
    gh.factory<_i682.HomeCubit>(() => _i682.HomeCubit(gh<_i94.HomeFactory>()));
    gh.factory<_i285.GetCurrentUserUsecase>(
      () => _i285.GetCurrentUserUsecase(gh<_i866.ProfileRepo>()),
    );
    gh.factory<_i499.ProductsSearchCubit>(
      () => _i499.ProductsSearchCubit(gh<_i985.GetProductUsecase>()),
    );
    gh.factory<_i259.AllCategoriesCubit>(
      () => _i259.AllCategoriesCubit(
        gh<_i710.AllCategoriesUsecase>(),
        gh<_i985.GetProductUsecase>(),
      ),
    );
    gh.factory<_i25.OccasionCubit>(
      () => _i25.OccasionCubit(gh<_i985.GetProductUsecase>()),
    );
    gh.factory<_i650.ProfileCubit>(
      () => _i650.ProfileCubit(
        gh<_i285.GetCurrentUserUsecase>(),
        gh<_i603.AuthStorage>(),
        gh<_i169.GetAboutSectionUsecase>(),
        gh<_i137.GetTermsSectionUsecase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
