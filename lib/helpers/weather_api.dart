import 'dart:convert';

import '../config/api_keys.dart';
import 'package:http/http.dart' as http;
import 'geolocation.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider {
  static const String unit = 'metric';
  bool hasGotData = false;
  double? _temperature;

  int get temperature {
    if (_temperature == null) {
      return 0;
    } else {
      return _temperature!.round();
    }
  }

  String? city;
  String? weather;

  Future<void> getWeatherDataWithGeolocation() async {
    Position position = await determinePosition();
    http.Response response = await http
        .get(Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'appid': weatherApiKey,
      'units': unit,
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
    }));
    Map<String, dynamic> map = jsonDecode(response.body);
    // print(map);
    hasGotData = true;
    _temperature = map['main']['temp'] as double;
    city = map['name'] as String;
    weather = map['weather'][0]['main'] as String;
  }
}
