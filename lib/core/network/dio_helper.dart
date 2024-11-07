import 'dart:io';

import 'package:busha_app/core/app_exception.dart';
import 'package:busha_app/core/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

typedef ProgressCallback = void Function(int count, int total);

@Singleton()
class DioClientWrapper {
  Dio _dioClient = Dio(BaseOptions(
    baseUrl: "https://blockchain.info/",
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    contentType: 'application/json',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    },
  ));

  Future<Response<dynamic>> get(url, {Options? options, dynamic data}) {
    return _makeRequest(() => _dioClient.get(url, options: options, data: data));
  }

  void changeBaseUrl(String baseUrl) {
    final String currentBaseUrl = _dioClient.options.baseUrl;
    if (currentBaseUrl == baseUrl) return;

    _dioClient = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      contentType: 'application/json',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ));
    AppLogger.debug("new base url is ${_dioClient.options.baseUrl}");
  }

  void resetBaseUrl() {}

  String _getErrorMessage(DioException exception) {
    final errorMap = exception.response!.data;
    String? message;
    if (errorMap["error"] == null) {
      message = errorMap["message"];
    } else {
      message = errorMap["error"];
    }
    AppLogger.debug("server error is ${exception.response!.data}");
    return message ?? "Oops! something went wrong.";
  }

  Future<Response<dynamic>> _makeRequest(Future<Response<dynamic>> Function() dioRequest) async {
    try {
      return await dioRequest.call();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          throw BushaAppException(
            "Your internet connection is unstable, please check and try again",
            stackTrace: e.stackTrace,
          );

        case DioExceptionType.cancel:
          throw BushaAppException(
            "Request cancelled",
            stackTrace: e.stackTrace,
            statusCode: e.response?.statusCode,
          );

        case DioExceptionType.unknown:
          throw BushaAppException("An unknown error occurred");

        case DioExceptionType.badResponse:
          if (e.response == null) {
            throw BushaAppException("An unknown error occurred", stackTrace: e.stackTrace);
          }
          switch (e.response!.statusCode) {
            case 409:
              return throw BushaAppException(_getErrorMessage(e), statusCode: 409, stackTrace: e.stackTrace);
            case 400:
              AppLogger.debug("server error is ${e.response!.data}");
              return throw BushaAppException(_getErrorMessage(e), stackTrace: e.stackTrace, statusCode: 400);
            case 401:
              return throw BushaAppException("Authorization error", statusCode: 401, stackTrace: e.stackTrace);
            case 404:
              throw BushaAppException("Resource not found", stackTrace: e.stackTrace, statusCode: 404);
            case 411:
              throw BushaAppException(
                _getErrorMessage(e),
                stackTrace: e.stackTrace,
                statusCode: 411,
              );
            case 500:
              AppLogger.debug("server error is ${e.response!.data}");
              final errorMap = e.response!.data;
              String message;
              if (errorMap["error"] == null) {
                message = errorMap["message"];
              } else {
                message = errorMap["message"];
              }
              return throw BushaAppException(message, stackTrace: e.stackTrace, statusCode: 500);
            default:
              throw BushaAppException("Oops! something went wrong.", stackTrace: e.stackTrace);
          }

        default:
          throw BushaAppException("An unknown error occurred");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw BushaAppException("An unknown error occurred");
    }
  }
}
