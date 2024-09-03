import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'error_interceptor.dart';
import 'log_interceptor.dart';

part 'dio_instance.g.dart';

@riverpod
Dio dioInstance(DioInstanceRef ref) {
  return DioInstance(ref);
}

class DioInstance with DioMixin implements Dio {
  DioInstance(
    this._ref,
  ) {
    final options = BaseOptions(
      contentType: 'application/json',
    );
    this.options = options;
    httpClientAdapter = IOHttpClientAdapter();
    _setUpInterceptor();
  }

  final Ref _ref;

  Future<void> _setUpInterceptor() async {
    interceptors.add(LogInterceptorsWrapper());
    interceptors.add(ErrorInterceptorsWrapper());
  }
}
