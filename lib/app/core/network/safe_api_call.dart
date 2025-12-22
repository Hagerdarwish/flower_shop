import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import 'api_result.dart';

Future<ApiResult<T>> safeApiCall<T>({
  required Future<HttpResponse<T>> Function() call,
  bool isBaseResponse = false,
}) async {
  print('safeApiCall: Starting API call, isBaseResponse=$isBaseResponse');
  try {
    final response = await call();
    if (response.response.statusCode! >= 200 &&
        response.response.statusCode! < 300) {
      return SuccessApiResult(data: response.data);
    } else {
      return ErrorApiResult(
        error: "Failed with status code: ${response.response.statusCode}",
      );
    }
  } on DioException catch (dioError) {
    return ErrorApiResult(error: "Dio error: ${dioError.response?.data['error']} ");
  } catch (e) {
    return ErrorApiResult(error: "Unexpected error: $e");
  }
}
