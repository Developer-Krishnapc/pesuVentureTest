import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../helper/dio_instance.dart';
import '../../model/weather_api_res.dart';
part 'weather_source.g.dart';

@riverpod
WeatherSource weatherSource(WeatherSourceRef ref) {
  return WeatherSource(ref.watch(dioInstanceProvider));
}

@RestApi()
abstract class WeatherSource {
  factory WeatherSource(Dio _dio) => _WeatherSource(_dio);
  @GET(Constants.getWeatherDetails)
  Future<WeatherResModel> getWeatherDetails(
    @Path() String region,
    @Path() String key,
  );
}
