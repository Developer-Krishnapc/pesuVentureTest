import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    @Default('') String name,
    @Default('') String region,
    @Default('') String country,
    @Default(0.0) double lat,
    @Default(0.0) double lon,
    @Default('') String localtime,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
