import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/network/api_result.dart';

@injectable
class AddAddressUsecase {
  final AddressRepo _addressRepo;
  AddAddressUsecase(this._addressRepo);

  Future<ApiResult<AddressDto>?> call({
    required String token,
    required AddressModel data,
  }) async {
    return await _addressRepo.addAddress(token, data);
  }
}
