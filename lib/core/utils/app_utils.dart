// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/model/api_res.dart';
import '../../presentation/shared/components/app_text_theme.dart';
import '../../presentation/shared/gen/assets.gen.dart';
import '../../presentation/theme/app_color.dart';
import '../exceptions/app_exception.dart';
import '../extension/widget.dart';

class AppUtils {
  static Either<DioException, Object?> checkError(
    dynamic data,
    RequestOptions requestOptions,
  ) {
    if (data is! Map<String, dynamic> || data is List) {
      return right(
        ApiRes(
          data: data,
        ).data,
      );
    }
    final apiRes = ApiRes.fromJson(data);
    if (apiRes.error?.message?.isNotEmpty == true) {
      return left(
        DioException(
          requestOptions: requestOptions,
          error: AppException(
            message: apiRes.error?.message ?? '',
            type: ErrorType.responseError,
          ),
        ),
      );
    }
    if (apiRes.data != null) {
      return right(apiRes.data);
    }
    return right(data);
  }

  static dynamic convertDataToMap(dynamic data) {
    final temp = <String, dynamic>{};
    if (data == null) {
      return temp;
    }
    if (data is String) {
      if (data.contains('{')) {
        return jsonDecode(data);
      }
      return temp..['data'] = data;
    }
    if (data is Map<String, dynamic>) {
      if (data.containsKey('data')) {
        return data['data'];
      }
      temp.addAll(data);
    }
    if (temp.isEmpty) {
      return data;
    }
    return temp;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> flushBar(
    BuildContext contextt,
    String message, {
    bool isSuccessPopup = true,
  }) {
    return ScaffoldMessenger.of(contextt).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            color: isSuccessPopup ? AppColor.green : AppColor.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              if (isSuccessPopup)
                Assets.svg.correctIcon.svg(height: 50, width: 50).padHor()
              else
                Assets.svg.incorrectIcon.svg(height: 60, width: 60).padHor(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSuccessPopup ? 'Success' : 'Error',
                      style: AppTextTheme.semiBold16
                          .copyWith(color: AppColor.white),
                    ),
                    Text(
                      message,
                      style:
                          AppTextTheme.label14.copyWith(color: AppColor.white),
                    ).padRight(),
                  ],
                ),
              ),
            ],
          ).padVer(10),
        ),
      ),
    );
  }

  static Color getStyleByWeather({required double temperature}) {
    switch (temperature.toInt()) {
      case final t when t <= 0:
        return Colors.blue.shade900;
      case final t when t > 0 && t <= 10:
        return Colors.blue.shade700;
      case final t when t > 10 && t <= 20:
        return Colors.lightBlue.shade500;
      case final t when t > 20 && t <= 30:
        return Colors.yellow.shade600;
      case final t when t > 30 && t <= 40:
        return Colors.orange.shade800;
      default:
        return Colors.red.shade900;
    }
  }
}
