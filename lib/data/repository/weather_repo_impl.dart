import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/extension/future.dart';
import '../../domain/repository/weather_repo.dart';
import '../model/weather_api_res.dart';
import '../source/remote/weather_source.dart';
part 'weather_repo_impl.g.dart';

@riverpod
WeatherRepository weatherRepo(WeatherRepoRef ref) {
  return WeatherRepositoryImpl(ref.watch(weatherSourceProvider));
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._source);

  final WeatherSource _source;

  @override
  Future<Either<AppException, WeatherResModel>> getWeatherDetails(
      {required String region}) {
    const key = String.fromEnvironment('WEATHER_API_KEY');
    return _source.getWeatherDetails(region, key).guardFuture();
  }

  @override
  Future<Either<AppException, WeatherResModel>> getWeatherDetailsByLatLng(
      {required lat, required lng}) {
    const key = String.fromEnvironment('WEATHER_API_KEY');
    return _source.getWeatherDetails('$lat,$lng', key).guardFuture();
  }
}
