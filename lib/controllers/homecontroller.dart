import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathercheckermaster/models/WeatherResponse.dart';

class HomeController extends GetxController {
  bool loading = true;
  bool error = false;
  bool farenheight = false;
  WeatherResponse? response;
  final String API_KEY = "806d00dde3ec9558678e665b189f60de";

  String constructURL({required double latitude, required double longitude}) {
    return "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=hourly,alerts,minutely&appid=${API_KEY}&units=${farenheight ? "imperial" : "metric"}";
  }

  setLoading(bool value) {
    loading = value;
    refresh();
  }

  @override
  void onInit() {
    super.onInit();
    print("Call init");
    getFarenHeight().then((value) {
      farenheight = value;
      refresh();
      getData();
    });
  }

  Future<bool> getFarenHeight() async {
    var prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool("farenheight");
    if (value == null) {
      await prefs.setBool("farenheight", false);
      value = false;
    }
    return value;
  }

  void switchFarenheight(bool v) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool("farenheight", v);
    farenheight = v;
    onInit();
    refresh();
  }

  void getData() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    late LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      print("Request permission");
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    print("Get location");
    _locationData = await location.getLocation();
    if (_locationData.latitude == null || _locationData.longitude == null) {
      print("No location");
      return;
    }
    String url = constructURL(
        latitude: _locationData.latitude!, longitude: _locationData.longitude!);
    print("URL: $url");
    getWeatherData(url);
  }

  String getSymbol() {
    return farenheight ? "\u2109" : "\u2103";
  }

  Future<void> getWeatherData(String url) async {
    setLoading(true);
    try {
      var res = await get(Uri.parse(url));
      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("Data is gotten");
        response = WeatherResponse.fromJson(jsonDecode(res.body));
        setLoading(false);
        if (error == true) {
          error = false;
        }
        refresh();
      }
    } catch (e) {
      print(e);
      error = true;
      setLoading(false);
    }
  }

  String getFeelsLike(FeelsLike? feelsLike) {
    final date = DateTime.now();

    if (feelsLike == null) {
      return "0";
    }
    if (date.hour > 0 && date.hour < 12) {
      return "${feelsLike.morn}";
    } else if (date.hour > 12 && date.hour < 16) {
      return "${feelsLike.day}";
    } else if (date.hour > 16 && date.hour < 18) {
      return "${feelsLike.eve}";
    } else {
      return "${feelsLike.night}";
    }
  }
}
