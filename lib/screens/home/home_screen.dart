import 'package:flutter/material.dart';
import '../../helpers/weather_api.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final WeatherProvider weatherProvider = WeatherProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherProvider.getWeatherDataWithGeolocation(),
      builder: (context, snapshot) => Container(
        height: 150,
        child: Card(
          color: Colors.red.shade200,
          child: weatherProvider.hasGotData
              ? ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                  title: Text(
                    weatherProvider.city ?? 'No',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  subtitle: Text(
                    weatherProvider.weather ?? 'No',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  trailing: Text(
                    weatherProvider.temperature.toString() + '°C',
                    style: TextStyle(fontSize: 50.0),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
