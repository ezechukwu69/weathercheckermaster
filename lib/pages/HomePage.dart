import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathercheckermaster/controllers/homecontroller.dart';
import 'package:weathercheckermaster/pages/SignInPage.dart';
import 'package:weathercheckermaster/utils/space.dart';

class HomePage extends StatefulWidget {
  static const String path = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.put(HomeController());
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "WeatherCheckerMaster",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignInPage.path, (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            size(height: 12),
            userHeader(),
            size(height: 12),
            GetBuilder<HomeController>(
              builder: (_controller) => _controller.loading
                  ? Expanded(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : !_controller.loading && _controller.error
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                size: 30,
                                color: Colors.red,
                              ),
                              size(height: 20),
                              Text(
                                "An error occurred",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                onPressed: () => _controller.onInit(),
                                child: Text(
                                  "Retry",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Current Weather Forecast",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            size(height: 8),
                                            Text(
                                              "${_controller.response?.timezone ?? ""}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Switch(
                                            value: _controller.farenheight,
                                            onChanged: (v) {
                                              _controller.switchFarenheight(v);
                                            })
                                      ],
                                    ),
                                  ),
                                  size(height: 14),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        weatherValueWithData(
                                            name: "Temp",
                                            value:
                                                "${_controller.response?.current?.temp} ${_controller.getSymbol()}"),
                                        weatherValueWithData(
                                            name: "Feels Like",
                                            value:
                                                "${_controller.response?.current?.feelsLike} ${_controller.getSymbol()}"),
                                        weatherValueWithData(
                                            name: "Weather",
                                            value: _controller.response?.current
                                                ?.weather?.first.description),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              size(height: 30),
                              Text(
                                "Daily Forecast",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              size(height: 8),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      size(height: 8),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        size(width: 4),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.red,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${getDay(_controller.response?.daily?[index].dt).day}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "${getDayOfWeek(getDay(_controller.response?.daily?[index].dt).weekday)}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        size(width: 8),
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 20),
                                              decoration: BoxDecoration(
                                                color: getDay(_controller
                                                                    .response
                                                                    ?.daily?[
                                                                        index]
                                                                    .dt)
                                                                .weekday %
                                                            2 ==
                                                        0
                                                    ? Colors.blueGrey
                                                        .withOpacity(0.1)
                                                    : Colors.red
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: weatherValueWithData(
                                                        name: "Temp",
                                                        value:
                                                            "${_controller.response?.daily?[index].temp?.day?.toStringAsFixed(1)} ${_controller.getSymbol()}"),
                                                  ),
                                                  Expanded(
                                                    child: weatherValueWithData(
                                                        name: "Feels Like",
                                                        value:
                                                            "${_controller.getFeelsLike(_controller.response?.daily?[index].feelsLike)} ${_controller.getSymbol()}"),
                                                  ),
                                                  Expanded(
                                                    child: weatherValueWithData(
                                                      name: "Min",
                                                      value: _controller
                                                          .response
                                                          ?.daily?[index]
                                                          .temp
                                                          ?.min,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: weatherValueWithData(
                                                      name: "Max",
                                                      value: _controller
                                                          .response
                                                          ?.daily?[index]
                                                          .temp
                                                          ?.max,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: weatherValueWithData(
                                                      name: "Weather",
                                                      value: _controller
                                                          .response
                                                          ?.daily?[index]
                                                          .weather
                                                          ?.first
                                                          .description,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount:
                                      _controller.response?.daily?.length ?? 0,
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherValueWithData({required String name, dynamic value}) {
    return Column(
      children: [
        Text(
          "$name",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        size(height: 4),
        Text(
          "${value ?? ""}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget userHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.photoURL != null
              ? CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL!))
              : CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  radius: 25,
                ),
          FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.email != null
              ? Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  DateTime getDay(double? sunrise) {
    final beforeUTC =
        DateTime.fromMillisecondsSinceEpoch(sunrise!.toInt() * 1000);
    print(
        "${beforeUTC.millisecondsSinceEpoch} - ${DateTime.now().millisecondsSinceEpoch}");
    final date = DateTime.utc(beforeUTC.year, beforeUTC.month, beforeUTC.day);
    return date;
  }

  String getDayOfWeek(int value) {
    switch (value) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }
}
