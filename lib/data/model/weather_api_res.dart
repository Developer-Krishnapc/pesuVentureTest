import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/location_model.dart';
part 'weather_api_res.freezed.dart';
part 'weather_api_res.g.dart';

@freezed
class WeatherResModel with _$WeatherResModel {
  const factory WeatherResModel({
    @Default(LocationModel()) LocationModel location,
    @JsonKey(name: 'current')
    @Default(CurrentWeatherModel())
    CurrentWeatherModel currentWeather,
  }) = _WeatherResModel;

  factory WeatherResModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherResModelFromJson(json);
}

@freezed
class CurrentWeatherModel with _$CurrentWeatherModel {
  const factory CurrentWeatherModel({
    @JsonKey(name: 'temp_c') @Default(0.0) double temp,
    @JsonKey(name: 'wind_kph') @Default(0.0) double windSpeed,
    @JsonKey(name: 'cloud') @Default(0.0) double cloud,
    @JsonKey(name: 'humidity') @Default(0.0) double humidity,
    @Default(ConditionModel()) ConditionModel condition,
  }) = _CurrentWeatherModel;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherModelFromJson(json);
}

@freezed
class ConditionModel with _$ConditionModel {
  const factory ConditionModel({
    @JsonKey(name: 'text') @Default('') String name,
    @JsonKey(name: 'icon') @Default('') String iconUrl,
  }) = _ConditionModel;

  factory ConditionModel.fromJson(Map<String, dynamic> json) =>
      _$ConditionModelFromJson(json);
}
