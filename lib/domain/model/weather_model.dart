import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/weather_api_res.dart';
import 'location_model.dart';
part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    @Default('') String selectedRegion,
    @Default(LocationModel()) LocationModel location,
    @Default(CurrentWeatherModel()) CurrentWeatherModel currentWeather,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
