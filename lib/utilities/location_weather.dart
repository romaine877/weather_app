

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Weather {
  final bool isDay;
  final String city, weather, weatherDescription;
  final int temp, weatherCode, sunrise, sunset, time;
  DateTime now = DateTime.now();
  Weather(
      {this.time,
      this.isDay,
      this.sunset,
      this.sunrise,
      this.weatherCode,
      this.weatherDescription,
      this.city,
      this.temp = 0,
      this.weather = ''});

  String getSunrise(bool isSunrise) {
    DateTime sunUp = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunDown = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);

    return isSunrise
        ? 'Sunrise: ' + sunUp.hour.toString() + ': ' + sunUp.minute.toString()
        : 'Sunset: ' + sunDown.hour.toString() + ': ' + sunDown.minute.toString();
  }

  IconData getWeatherIcon() {
    
    if (isDay) {
      if (weatherCode < 300) {
        return WeatherIcons.wi_day_thunderstorm;
      } else if (weatherCode < 400) {
        return WeatherIcons.wi_day_showers;
      } else if (weatherCode < 600) {
        return WeatherIcons.wi_day_sprinkle;
      } else if (weatherCode < 700) {
        return WeatherIcons.wi_day_snow;
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
    } else {
      if (weatherCode < 300) {
        return WeatherIcons.wi_night_thunderstorm;
      } else if (weatherCode < 400) {
        return WeatherIcons.wi_night_showers;
      } else if (weatherCode < 600) {
        return WeatherIcons.wi_night_sprinkle;
      } else if (weatherCode < 700) {
        return WeatherIcons.wi_night_snow;
      } else if (weatherCode < 800) {
        return WeatherIcons.wi_dust;
      } else if (weatherCode == 800) {
        return WeatherIcons.wi_night_clear;
      } else if (weatherCode == 801) {
        return WeatherIcons.wi_night_cloudy;
      } else if (weatherCode == 802) {
        return WeatherIcons.wi_night_cloudy;
      } else if (weatherCode == 803 || weatherCode == 804) {
        return WeatherIcons.wi_cloudy;
      } else {
        return WeatherIcons.wi_alien;
      }
    }
  }
  
}
