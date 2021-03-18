import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Weather {
  final String city, weather, weatherDescription;
  final int temp, weatherCode, sunrise, sunset, time;
  DateTime now = DateTime.now();
  Weather(
      {this.time,
      this.sunset,
      this.sunrise,
      this.weatherCode,
      this.weatherDescription,
      this.city,
      this.temp = 0,
      this.weather = ''});

  String getSunrise() {
    DateTime sunUp = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunDown = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    DateTime uTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    // print(sunDown);
    // print(uTime);
    print(sunDown);
        

    // print(sunUp);
    
    int hours = sunUp.difference(now).inHours;
    int minutes = sunUp.difference(now).inMinutes % 60;
    print(sunUp.hour.toString() + 'H' + sunUp.minute.toString() + 'm ' + 'before sunset');
    return hours.toString() + ': ' + minutes.toString() + 'M';
  }

  IconData getWeatherIcon() {
    if (weatherCode < 300) {
      return WeatherIcons.wi_thunderstorm;
    } else if (weatherCode < 400) {
      return WeatherIcons.wi_showers;
    } else if (weatherCode < 600) {
      return WeatherIcons.wi_sprinkle;
    } else if (weatherCode < 700) {
      return WeatherIcons.wi_snow;
    } else if (weatherCode < 800) {
      return WeatherIcons.wi_dust;
    } else if (weatherCode == 800) {
      return WeatherIcons.wi_day_sunny;
    } else if (weatherCode == 801) {
      return WeatherIcons.wi_day_cloudy;
    } else if (weatherCode == 802) {
      return WeatherIcons.wi_day_cloudy;
    } else if (weatherCode == 803 || weatherCode == 804) {
      return WeatherIcons.wi_cloudy;
    } else {
      return WeatherIcons.wi_alien;
    }
  }
}
