import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repository/weather_repo_impl.dart';
import '../../../data/source/local/shar_pref.dart';
import '../../../domain/model/weather_model.dart';
import '../../shared/model/user_state.dart';

part 'weather_notifer.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  @override
  UserState<WeatherModel> build() {
    return UserState(data: const WeatherModel(), loading: false);
  }

  Future<void> getWeatherByRegion({required String region}) async {
    if (region.isEmpty) {
      return;
    }
    state = state.copyWith(
        loading: true,
        error: '',
        data: state.data.copyWith(selectedRegion: region));
    final res =
        await ref.read(weatherRepoProvider).getWeatherDetails(region: region);
    res.fold((l) {
      state = state.copyWith(loading: false, error: l.message);
    }, (r) {
      state = state.copyWith(
        loading: false,
        error: '',
        data: state.data.copyWith(
          selectedRegion: r.location.name,
          currentWeather: r.currentWeather,
          location: r.location,
        ),
      );
      ref.read(sharedPrefProvider).saveRegion(region);
    });
  }

  Future<void> getWeatherByLatLng() async {
    state = state.copyWith(
      loading: true,
      error: '',
    );
    final res = await checkPermission();
    await res.fold((l) {
      state = state.copyWith(
        loading: false,
        error: l,
      );
    }, (r) async {
      final weatherReport = await ref
          .read(weatherRepoProvider)
          .getWeatherDetailsByLatLng(lat: r.latitude, lng: r.longitude);
      weatherReport.fold((l) {
        state = state.copyWith(
          loading: false,
          error: l.message,
        );
      }, (result) {
        state = state.copyWith(
          loading: false,
          error: '',
          data: state.data.copyWith(
            selectedRegion: result.location.name,
            currentWeather: result.currentWeather,
            location: result.location,
          ),
        );
        ref.read(sharedPrefProvider).saveRegion(result.location.name);
      });
    });
  }

  Future<Either<String, Position>> checkPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left('Location permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const Left(
          'Location is denied forever, please move on to settings and enable the location permission for the app');
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return Right(position);
    } catch (e) {
      return const Left('Your Location / GPS is not enabled');
    }
  }
}
