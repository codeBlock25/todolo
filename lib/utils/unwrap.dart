import 'package:dio/dio.dart';
import 'package:todolo/logic/error/error.dart';

Future<T> unwrap<T>(Future<T> future) async {
  try {
    return await future;
  } on DioException catch (raw) {
    final rawError = raw.response?.data;
    if (rawError == null) {
      throw ErrorResponse(
        message:
            'Network Error, please check your internet connection and try again.',
      );
    }
    throw ErrorResponse.fromJson(rawError);
  } catch (err) {
    if (err is ErrorResponse) {
      rethrow;
    }
    throw ErrorResponse(
      message:
          'Ops!, an error occurred while processing your request. Please try again later.',
    );
  }
}
