import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_flutter_app/models/weather_model.dart';
import 'package:my_flutter_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage ( { super.key } );

  @override
  State<WeatherPage> createState ( ) => _WeatherPageState ( );
}

class _WeatherPageState extends State <WeatherPage> {

  // api key
  final _weatherService = WeatherService ( 'd0c1bc03aa23c10078be2b5d34fe5922' );
  Weather? _weather;
 
  // fetch weather
  _fetchWeather ( ) async {

    //get weather for city
    String cityName = await _weatherService.getCurrentCity ( );

    //get weather for city
    try {
      final weather = await _weatherService.getWeather ( cityName );
      setState ( () {
        _weather = weather;

      });
    }

    // any errors
    catch ( e ) {
      print ( e );

    }
  }

  // weather animations
  String getWeatherAnimation ( String? mainCondition ) {

    if ( mainCondition == null ) return ' assets/sunny.json '; // default to sunny

      switch ( mainCondition.toLowerCase ( ) ) {

        case 'clouds': 
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloudy.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/rainy.json';
        case 'thunderstorm':
          return 'assets/stormy.json';
        case 'clear':
          return 'assets/sunny.json';
        default: 
          return 'assets/sunny.json';
          
      }

  }

  // init state
  @override
  void initState ( ) {
    super.initState ( );

    // fetch weather on startup
    _fetchWeather ( );

  }

  @override
  Widget build ( BuildContext context ) {
    return Scaffold ( 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            // city name
            Text ( _weather?.cityName ?? "loading city..." ),

            // animation
            Lottie.asset ( 'assets/rainy.json' ),

            // temperature
            Text('${_weather?.temperature.round()}°C'),

            // weather condition
            Text( _weather?.mainCondition ?? "" )

        ],
       ),
      ),
    );
  }
}