import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utilities/location_weather.dart';

class SplashScreen extends StatelessWidget {
  final Weather weather;
  final String backgroundImage;

  SplashScreen({this.weather, this.backgroundImage});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:  NetworkImage(backgroundImage),fit: BoxFit.cover),
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
                  Text(weather.temp.toString()+'°',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: size.height * .15)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('${weather.weatherDescription} at ${weather.city}',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: size.height * .07)),
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
                    Text(
                      weather.getSunrise(),
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: size.height * .06),
                    ),
                    Text(
                      'Before Sunset',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          //fontWeight: FontWeight.w700,
                          fontSize: 20),
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
