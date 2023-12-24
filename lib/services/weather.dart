import 'package:weather_app1/services/location.dart';
import 'package:weather_app1/services/networking.dart';
const apiKey = 'cff04fd4ddb5170785082ae4465adcca'; // this is the api key from openweather site
const callByCityNameApi = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  // This function helps in fetching weatherdata using the cityname
  Future<dynamic> getWeatherByCityName(String cityName)
  async{
      var url = Uri.parse('$callByCityNameApi?q=$cityName&appid=$apiKey&units=metric');
      NetworkHelper networkHelper = NetworkHelper(url);
      var weatherData = await networkHelper.getData();
      return weatherData;
  }

// This function helps in fetching the location your current postion using the location of your phone's GPS
  Future<dynamic> getLocationWeather()
  async{
      Location location = Location();      // Object of the Location class from the location.dart file
      await location.getCurrentposition();
      var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude!}&lon=${location.longitude!}&appid=$apiKey&units=metric');       //stored the co-ordinates which came from the location.dart file
      NetworkHelper networkHelper = NetworkHelper(url);     // object of Networkhelper class from networking.dart file
      var weatherData = await networkHelper.getData();
      return weatherData;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20 && temp < 25) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
