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

      // Safely check if the response data has 'error' property
      final data = response.data;
      if (data != null) {
        try {
          // If it's a Map, look for 'error'
          if (data is Map<String, dynamic> && data.containsKey('error')) {
            errorMessage = data['error'].toString();
          }
          // If it's a typed object with 'error' property
          else if (data is dynamic && data.toString().contains('error')) {
            final map = Map<String, dynamic>.from(data as dynamic);
            if (map.containsKey('error')) {
              errorMessage = map['error'].toString();
            }
          }
        } catch (_) {
          // ignore parsing errors
        }
      }

      return ErrorApiResult(error: errorMessage);
    }
  } on DioException catch (dioError) {
    String message = "Dio error occurred";
    try {
      final data = dioError.response?.data;
      if (data != null) {
        if (data is Map<String, dynamic> && data.containsKey('error')) {
          message = data['error'].toString();
        }
      } else if (dioError.message != null) {
        message = dioError.message!;
      }
    } catch (_) {}
    return ErrorApiResult(error: message);
  } catch (e) {
    return ErrorApiResult(error: "Unexpected error: $e");
  }
}
