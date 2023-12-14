import 'dart:convert';
import 'package:weather_app1/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weather_app1/utilities/constants.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationData});

  final dynamic locationData; // this is stateful widget object

  @override
  LocationScreenState createState() => LocationScreenState();
}
class LocationScreenState extends State<LocationScreen> {
  int ?temperature;
  String ?cityname;
  String ?message;
  String ?condi;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState()
  {
    super.initState();
    updateUi(widget.locationData); // here we accessed the stateful widget object inside the state
  }

  void updateUi(dynamic weatherdata)
  {
    var condition  = jsonDecode(weatherdata)['weather'][0]['id'];
    double temp = jsonDecode(weatherdata)['main']['temp'];
    temperature = temp.toInt();
    cityname = jsonDecode(weatherdata)['name'];
    message = weatherModel.getMessage(temperature!);
    condi = weatherModel.getWeatherIcon(condition!);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                     Text(
                      '$condi',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message time in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
