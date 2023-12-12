import 'package:flutter/material.dart';import 'package:flutter_spinkit/flutter_spinkit.dart';import 'package:geolocator/geolocator.dart';import 'package:weather_app1/screens/location_screen.dart';import 'package:weather_app1/services/networking.dart';import 'package:weather_app1/services/location.dart';const apiKey = 'cff04fd4ddb5170785082ae4465adcca'; // this is the api key from openweather siteclass LoadingScreen extends StatefulWidget {  const LoadingScreen({super.key});  @override  LoadingScreenState createState() => LoadingScreenState();}class LoadingScreenState extends State<LoadingScreen> {  late double latitude;  late double longitude;  var locationData;  @override  void initState() {    super.initState();    _checkLocationStatus();    // Putting this function into this function will give output wihthout prompting the user to click anywhere(One the permission is given)  }  Future<void> _checkLocationStatus() async {    bool serviceEnabled;    LocationPermission permission;    // Check if location service is enabled    serviceEnabled = await Geolocator.isLocationServiceEnabled();    if(!serviceEnabled)    {      _showLocationServiceDialog();    }    // Request location permission    permission = await Geolocator.requestPermission();    if (permission == LocationPermission.denied) {      // Handle case when permission is denied      _showPermissionDeniedDialog();    }    if (permission == LocationPermission.deniedForever) {      // Handle case when permission is permanently denied      _showPermissionDeniedForeverDialog();    }  }  void _showLocationServiceDialog() {    showDialog(      context: context,      builder: (context) => AlertDialog(        title: const Text('Location Services Disabled'),        content: const Text('Please enable location services to use this app.'),        actions: [          TextButton(            onPressed: () {              Navigator.pop(context);              // Open device settings to enable location services              Geolocator.openLocationSettings();            },            child: const Text('Open Settings'),          ),        ],      ),    );  }  void _showPermissionDeniedDialog() {    showDialog(      context: context,      builder: (context) => AlertDialog(        title: const Text('Location Permission Denied'),        content: const Text('Please grant location permission to use this app.'),        actions: [          TextButton(            onPressed: () {              Navigator.pop(context);              // Request location permission again              _checkLocationStatus();            },            child: const Text('Retry'),          ),        ],      ),    );  }  void _showPermissionDeniedForeverDialog() {    showDialog(      context: context,      builder: (context) => AlertDialog(        title: const Text('Location Permission Denied'),        content: const Text('Please enable location permission in your device settings.'),        actions: [          TextButton(            onPressed: () {              Navigator.pop(context);              // Open app settings to enable location permission              Geolocator.openAppSettings();            },            child: const Text('Open App Settings'),          ),        ],      ),    );  }  Future<void> getLocationData()  async {    Location location = Location(); // Object of the Location class from the location.dart file    await location.getCurrentposition();    latitude = location.latitude!;    longitude = location.longitude!;    //stored the co-ordinates which came from the location.dart file    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric ');    NetworkHelper networkHelper = NetworkHelper(url);// object of Networkhelper class from networking.dart file    var weatherData = await networkHelper.getData();     Navigator.push(context, MaterialPageRoute(builder: (context) // We navigated to other window and also we pushed the weather data to the location_screen.dart file    {      return  LocationScreen(locationData: weatherData);    }    ),    );  }  @override  Widget build(BuildContext context)  {    getLocationData();    return const Scaffold(      body:  Center(        child: SpinKitWaveSpinner( // Loading spinner which is shown when the data is retrieved via API and .          color: Colors.green,          size: 100.0,        ),      ),    );  }}