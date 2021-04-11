import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utilities/location_weather.dart';
import '../utilities/location.dart';

class SplashScreen extends StatelessWidget {
  final Weather weather;
  final String backgroundImage;

  SplashScreen({this.weather, this.backgroundImage});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Location(),
          ),
        ),
        backgroundColor: Colors.blue,
        child: Icon(Icons.replay),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(backgroundImage), fit: BoxFit.cover),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    weather.getWeatherIcon(),
                    size: size.height * .15,
                  ),
                  Stack(
                    children: [
                      Text(weather.temp.toString() + '°',
                          style: GoogleFonts.montserrat(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.white30,
                              fontWeight: FontWeight.w700,
                              fontSize: 100)),
                      Text(weather.temp.toString() + '°',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700, fontSize: 100)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(children: [
                Text('${weather.weatherDescription} at ${weather.city}',
                    style: GoogleFonts.montserrat(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.white30,
                        fontWeight: FontWeight.w700,
                        fontSize: size.height * .07)),
                Text('${weather.weatherDescription} at ${weather.city}',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: size.height * .07)),
              ]),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: size.height * .23,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Icon(
                          WeatherIcons.wi_sunrise,
                          color: Colors.white,
                        ),
                        Text(
                          weather.getSunrise(true),
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Icon(
                          WeatherIcons.wi_sunset,
                          color: Colors.white,
                        ),
                        Text(
                          weather.getSunrise(false),
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
