import 'package:http/http.dart'as http;  // used the as keyword to name this library as http


class NetworkHelper{
  NetworkHelper(this.url);
  final Uri url;
  Future getData()async
  {
    http.Response response = await http.get(url);
    // as we renamed the library where the get method is defined as http so we have to use the http before its function in this file.

    // var url = Uri.parse(url);
    // // Remember  All APIs which previously allowed a String or Uri to be passed now require a Uri.
    if(response.statusCode == 200)
    {
      String data = response.body;
      return data;
    }
    else{
      print(response.statusCode);
    }
  }



}
// https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey