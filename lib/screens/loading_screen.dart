import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    _checkLocationStatus();
    getLocation(); // Putting this function into this function will give output wihthout prompting the user to click anywhere(One the permission is given)
  }
  Future<void> _checkLocationStatus() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
      {
        _showLocationServiceDialog();
      }

    // Request location permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle case when permission is denied
      _showPermissionDeniedDialog();
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle case when permission is permanently denied
      _showPermissionDeniedForeverDialog();
    }
  }
  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text('Please enable location services to use this app.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Open device settings to enable location services
              Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text('Please grant location permission to use this app.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Request location permission again
              _checkLocationStatus();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text('Please enable location permission in your device settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Open app settings to enable location permission
              Geolocator.openAppSettings();
            },
            child: const Text('Open App Settings'),
          ),
        ],
      ),
    );
  }
  Future<void> getLocation()
  async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
