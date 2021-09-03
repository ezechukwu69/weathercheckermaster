class WeatherResponse {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;
  List<Daily>? daily;

  WeatherResponse(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.daily});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    lon = json['lon']?.toDouble();
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(new Daily.fromJson(v));
      });
      print("Daily length: ${daily!.length}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.current != null) {
      data['current'] = this.current?.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily?.map((v) => v.toJson()).toList() ?? [];
    }
    return data;
  }
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? uvi;
  double? clouds;
  double? visibility;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    pressure = json['pressure']?.toDouble();
    humidity = json['humidity']?.toDouble();
    dewPoint = json['dew_point']?.toDouble();
    uvi = json['uvi']?.toDouble();
    clouds = json['clouds']?.toDouble();
    visibility = json['visibility']?.toDouble();
    windSpeed = json['wind_speed']?.toDouble();
    windDeg = json['wind_deg']?.toDouble();
    windGust = json['wind_gust']?.toDouble();
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather?.map((v) => v.toJson()).toList() ?? [];
    }
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Daily {
  double? dt;
  double? sunrise;
  double? sunset;
  double? moonrise;
  double? moonset;
  double? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? clouds;
  double? pop;
  double? uvi;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'].toDouble();
    sunrise = json['sunrise'].toDouble();
    sunset = json['sunset'].toDouble();
    moonrise = json['moonrise'].toDouble();
    moonset = json['moonset'].toDouble();
    moonPhase = json['moon_phase']?.toDouble();
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? new FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure']?.toDouble();
    humidity = json['humidity']?.toDouble();
    dewPoint = json['dew_point']?.toDouble();
    windSpeed = json['wind_speed']?.toDouble();
    windDeg = json['wind_deg']?.toDouble();
    windGust = json['wind_gust']?.toDouble();
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(new Weather.fromJson(v));
      });
    }
    clouds = json['clouds']?.toDouble();
    pop = json['pop']?.toDouble();
    uvi = json['uvi']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['moon_phase'] = this.moonPhase;
    if (this.temp != null) {
      data['temp'] = this.temp?.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike?.toJson();
    }
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather?.map((v) => v.toJson()).toList() ?? [];
    }
    data['clouds'] = this.clouds;
    data['pop'] = this.pop;
    data['uvi'] = this.uvi;
    return data;
  }
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day']?.toDouble();
    min = json['min']?.toDouble();
    max = json['max']?.toDouble();
    night = json['night']?.toDouble();
    eve = json['eve']?.toDouble();
    morn = json['morn']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day']?.toDouble();
    night = json['night']?.toDouble();
    eve = json['eve']?.toDouble();
    morn = json['morn']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}
