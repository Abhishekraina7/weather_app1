
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location{
  Location({this.latitude, this.longitude});
  late double ?latitude;
  late double ?longitude;
   Future<void> getCurrentposition() async
   {
     try{
       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
       latitude = position.latitude;
       longitude = position.longitude;
     }
     catch(e)
     {
       print(e);
     }
   }

}