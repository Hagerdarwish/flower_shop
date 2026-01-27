import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepo)
class AddressRepoImp implements AddressRepo {
  final AddressDatasource addressDatasource;
  AddressRepoImp({required this.addressDatasource});

  @override
  Future<ApiResult<AddressResponse>> getAddresses({
    required String token,
  }) async {
    final result = await addressDatasource.getAddresses(token: token);
    if (result is SuccessApiResult<AddressResponse>) {
      return SuccessApiResult<AddressResponse>(data: result.data);
    }
    if (result is ErrorApiResult<AddressResponse>) {
      return ErrorApiResult<AddressResponse>(error: result.error);
    }
    return ErrorApiResult<AddressResponse>(error: 'Unknown error');
  }

  @override
  Future<ApiResult<AddressResponse>> deleteAddress({
    required String token,
    required String addressId,
  }) async {
    final result = await addressDatasource.deleteAddress(
      token: token,
      addressId: addressId,
    );
    if (result is SuccessApiResult<AddressResponse>) {
      return SuccessApiResult<AddressResponse>(data: result.data);
    }
    if (result is ErrorApiResult<AddressResponse>) {
      return ErrorApiResult<AddressResponse>(error: result.error);
    } else {
      return ErrorApiResult<AddressResponse>(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<AddressResponse>> editAddress({
    required String token,
    required String addressId,
    required String street,
    required String phone,
    required String city,
    required String lat,
    required String long,
    required String username,
  }) {
    final result = addressDatasource.editAddress(
      token: token,
      addressId: addressId,
      addressRequest: AddressRequest(
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      ),
    );
    return result.then((value) {
      if (value is SuccessApiResult<AddressResponse>) {
        return SuccessApiResult<AddressResponse>(data: value.data);
      }
      if (value is ErrorApiResult<AddressResponse>) {
        return ErrorApiResult<AddressResponse>(error: value.error);
      }
      return ErrorApiResult<AddressResponse>(error: 'Unknown error');
    });
  }
}
