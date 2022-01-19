import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/utilities/location_weather.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../keys.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String latData, longData, output = '...';
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
      //forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.high,
    );
    print('lat:');
    print(position.latitude.toString());
    getData(position.latitude, position.longitude);
  }

  void getData(double lat, double lon) async {
    String daytime;
    setState(() {
      output = 'calling weather api..';
    });
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        output = 'weather recieved';
      });
      var source = response.body;
      var city = jsonDecode(source)['name'];
      var weather = jsonDecode(source)['weather'][0]['main'];
      var dayIcon = jsonDecode(source)['weather'][0]['icon'];
      var weatherDescription = jsonDecode(source)['weather'][0]['description'];
      var temp = jsonDecode(source)['main']['temp'];
      var weatherCode = jsonDecode(source)['weather'][0]['id'];
      var sunrise = jsonDecode(source)['sys']['sunrise'];
      var sunset = jsonDecode(source)['sys']['sunset'];
      var time = jsonDecode(source)['dt'];
      weatherDescription = toBeginningOfSentenceCase(weatherDescription);
      print(city);
      print(weatherDescription);
      print(weatherCode);

      if (dayIcon.toString().endsWith('d')) {
        daytime = 'day';
      } else {
        daytime = 'night';
      }

      var imgApi = Uri.parse(
          'https://api.unsplash.com/search/photos?query=$daytime%$weather&client_id=7nK3X3iEPmcNodYN8-apzG5rWKWRwiAFAAmsdVJW26E');
      http.Response imgResponse = await http.get(imgApi);

      setState(() {
        output = 'calling image api...';
      });
      int actualTemp = temp.toInt();
      actualTemp = num.parse(actualTemp.toStringAsFixed(0));
      temp = actualTemp;
      setState(() {
        output = 'gcreating weather object...';
      });
      Weather locationWeather = Weather(
        city: city,
        weather: weather,
        weatherDescription: weatherDescription,
        temp: actualTemp,
        sunrise: sunrise,
        sunset: sunset,
        weatherCode: weatherCode,
        time: time,
        isDay: dayIcon.toString().endsWith('d'),
      );
      if (imgResponse.statusCode == 200) {
        setState(() {
          output = 'image recieved';
        });
        String imgUrl = jsonDecode(imgResponse.body)['results']
            [Random().nextInt(10)]['urls']['full'];
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
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        children: [
          SpinKitWave(
            color: Colors.yellow,
            size: 100,
          ),
          SizedBox(
            height: 30,
          ),
          Text(output,
              style: GoogleFonts.ubuntu(fontSize: 10, color: Colors.white))
        ],
      )),
    );
  }
}
