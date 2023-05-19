import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {

  final Dio dio;

  DioClient(this.dio);

  // GET
  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

}