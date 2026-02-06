import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/mappers/products_mapper.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/address_dto.dart';
import '../models/response/add_address_response_model.dart';
import '../models/response/address_model.dart';

@Injectable(as: AddressRepo)
class AddressRepoImp implements AddressRepo {
  final AddressDatasource addressDatasource;

  AddressRepoImp({required this.addressDatasource});

  @override
  Future<ApiResult<List<AddressEntity>>> getAddresses({
    required String token,
  }) async {
    final result = await addressDatasource.getAddresses(token: token);

    if (result is SuccessApiResult<GetAddressResponse>) {
      return SuccessApiResult<List<AddressEntity>>(
        data: result.data.toEntityList(),
      );
    }

    if (result is ErrorApiResult<GetAddressResponse>) {
      return ErrorApiResult<List<AddressEntity>>(error: result.error);
    }

    return ErrorApiResult<List<AddressEntity>>(error: 'Unknown error');
  }

  @override
  Future<ApiResult<List<AddressEntity>>> deleteAddress({
    required String token,
    required String addressId,
  }) async {
    final result = await addressDatasource.deleteAddress(
      token: token,
      addressId: addressId,
    );

    if (result is SuccessApiResult<AddressResponse>) {
      return SuccessApiResult<List<AddressEntity>>(
        data: result.data.toEntityList(),
      );
    }
    if (result is ErrorApiResult<AddressResponse>) {
      return ErrorApiResult<List<AddressEntity>>(error: result.error);
    }

    return ErrorApiResult<List<AddressEntity>>(error: 'Unknown error');
  }

  @override
  Future<ApiResult<AddressDto>?> addAddress(
    String token,
    AddressModel addAddressRequest,
  ) async {
    final response = await addressDatasource.addAddress(
      token,
      addAddressRequest,
    );
    switch (response) {
      case SuccessApiResult<AddAddressResponse>():
        return SuccessApiResult(data: response.data.toAddress());
      case ErrorApiResult<AddAddressResponse>():
        return ErrorApiResult(error: response.error);
      case null:
        return null;
    }
  }

  @override
  Future<ApiResult<List<AddressEntity>>> editAddress({
    required String token,
    required String addressId,
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  }) async {
    final result = await addressDatasource.editAddress(
      token: token,
      addressId: addressId,
      addressRequest: AddressModel(
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      ),
    );

    if (result is SuccessApiResult<AddressResponse>) {
      return SuccessApiResult<List<AddressEntity>>(
        data: result.data.toEntityList(),
      );
    }

    if (result is ErrorApiResult<AddressResponse>) {
      return ErrorApiResult<List<AddressEntity>>(error: result.error);
    }

    return ErrorApiResult<List<AddressEntity>>(error: 'Unknown error');
  }
}
