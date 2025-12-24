
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_result.dart';

Future<ApiResult<T>> safeApiCall<T>({
  required Future<HttpResponse<T>> Function() call,
  bool isBaseResponse = false,
}) async {
  try {
    final response = await call();
    if (response.response.statusCode! >= 200 &&
        response.response.statusCode! < 300) {
      return SuccessApiResult(data: response.data);
    } else {
      String errorMessage = "Failed with status code: ${response.response.statusCode}";
      final data = response.data;
      if (data != null) {
        try {
          if (data is Map<String, dynamic>) {
            if (data.containsKey('error')) {
              errorMessage = data['error'].toString();
            }
          }
        } catch (_) {
        }
      }
      return ErrorApiResult(error: errorMessage);
    }
  } on DioException catch (dioError) {
    String message = "Network error occurred";
    try {
      final data = dioError.response?.data;
      if (data != null) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey('error')) {
            message = data['error'].toString();
          } else if (data.containsKey('message')) {
            message = data['message'].toString();
          }
        }
      }
    } catch (_) {}
    return ErrorApiResult(error: message);
  } catch (e) {
    return ErrorApiResult(error: "Unexpected error: $e");
  }
}



