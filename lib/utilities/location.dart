import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/utilities/location_weather.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String latData, longData, citySata;
  void getWeather() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print('error, service disabled');
    }
    print('service enabled');

    permission = await Geolocator.checkPermission();
    print('checking permission...');

    if (permission == LocationPermission.denied) {
      print('permission denied, requesting permission');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print('permission permanently denied');
        Weather locationWeather = Weather(city: 'permanently denied');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SplashScreen(
                      weather: locationWeather,
                    )));
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        Weather locationWeather = Weather(city: 'denied');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SplashScreen(weather: locationWeather)));
        return Future.error('Location permissions are denied');
      }
    }

    print('getting location...');
    Position position = await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.lowest,
    );
    print('lat:');
    print(position.latitude.toString());
    getData(position.latitude, position.longitude);
  }

  void getData(double lat, double lon) async {
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=7c58b9aee0f46df2661b4d6da17fb041');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var source = response.body;
      var city = jsonDecode(source)['name'];
      var weather = jsonDecode(source)['weather'][0]['main'];
      var weatherDescription = jsonDecode(source)['weather'][0]['description'];
      var temp = jsonDecode(source)['main']['temp'];
      var weatherCode = jsonDecode(source)['weather'][0]['id'];
      var sunrise = jsonDecode(source)['sys']['sunrise'];
      var sunset = jsonDecode(source)['sys']['sunset'];
      var time = jsonDecode(source)['dt'];
      weatherDescription = toBeginningOfSentenceCase(weatherDescription);
      print(city);
      print(weatherDescription);
      print(temp);

      var imgApi = Uri.parse(
          'https://api.unsplash.com/search/photos?query=$weather&client_id=7nK3X3iEPmcNodYN8-apzG5rWKWRwiAFAAmsdVJW26E');
      http.Response imgResponse = await http.get(imgApi);

      setState(() {
        citySata = city;
      });
      int actualTemp = temp.toInt();
      actualTemp = num.parse(actualTemp.toStringAsFixed(0));
      temp = actualTemp;

      Weather locationWeather = Weather(
        city: city,
        weather: weather,
        weatherDescription: weatherDescription,
        temp: actualTemp,
        sunrise: sunrise,
        sunset: sunset,
        weatherCode: weatherCode,
        time: time,
      );
      if (imgResponse.statusCode == 200) {
        
        String imgUrl =
            jsonDecode(imgResponse.body)['results'][Random().nextInt(10)]['urls']['full'];
        print('Image Response: ');
        print(imgResponse.statusCode);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(
              weather: locationWeather,
              backgroundImage: imgUrl,
            ),
          ),
        );
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: SpinKitWave(
        color: Colors.yellow,
        size: 100,
      )),
    );
  }
}
