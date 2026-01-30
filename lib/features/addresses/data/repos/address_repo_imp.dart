import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/mappers/products_mapper.dart';
import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AddressRepo)

class AddressRepoImpl extends AddressRepo{
  final AddressDatasource addressDatasource;
  AddressRepoImpl(this.addressDatasource);


@override
Future<ApiResult<AddressDto>?> addAddress(String token, AddressModel addAddressRequest) async {
  final response = await addressDatasource.addAddress(token, addAddressRequest);
  switch (response) {
    case SuccessApiResult<AddAddressResponse>():
      return SuccessApiResult(data: response.data.toAddress());
    case ErrorApiResult<AddAddressResponse>():
      return ErrorApiResult(error: response.error);
    case null:
      return null;
  }
}}

