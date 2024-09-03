import 'flavor.dart';

class Constants {
  Constants._({
    required this.flavor,
    required this.baseUrl,
  });

  final Flavor flavor;
  final String baseUrl;

  // Weather Api
  static const String weatherApiKey = String.fromEnvironment('WEATHER_API_KEY');

  //Endpoint
  static const String getWeatherDetails =
      'http://api.weatherapi.com/v1/current.json?key={key}&q={region}&aqi=no';
}
