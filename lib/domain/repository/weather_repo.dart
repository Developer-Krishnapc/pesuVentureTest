import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../../data/model/weather_api_res.dart';

abstract class WeatherRepository {
  Future<Either<AppException, WeatherResModel>> getWeatherDetails(
      {required String region});

  Future<Either<AppException, WeatherResModel>> getWeatherDetailsByLatLng(
      {required double lat, required double lng});
}
