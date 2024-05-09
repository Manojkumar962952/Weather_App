import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/Addinfo.dart';
import 'package:weatherapp/WeatherInfo.dart';
import 'package:weatherapp/api.dart';

class HomeWeather extends StatefulWidget {
  const HomeWeather({Key? key}) : super(key: key);

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  bool isload = true;
  void initState() {
    super.initState();
    getweatherApiinfo();
  }

  Future<Map<String, dynamic>> getweatherApiinfo() async {
    try {
      String city = "India";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$ApiKey"));
      final data = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw "unexpected error";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getweatherApiinfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        }

        final data = snapshot.data!;
        final currentdata = data['list'][0];
        final maintemp = currentdata['main']['temp'];
        final mainweatherdescription = currentdata['weather'][0]['main'];
        final humidity = currentdata['main']['humidity'];
        final pressure = currentdata['main']['pressure'];
        final windspeed = currentdata['wind']['speed'];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.refresh)),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$maintemp K",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                mainweatherdescription == 'Clouds' ||
                                        mainweatherdescription == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 30,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$mainweatherdescription",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Weather Informations",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final tempss = data['list'][index]['main']['temp'];
                        final dtemp = data['list'][index]['dt'];
                        final desmain =
                            data['list'][index]['weather'][0]['main'];
                        final datet =
                            DateTime.parse(data['list'][index]['dt_txt']);
                        return WeatherInfo(
                          degree: DateFormat.Hm().format(datet),
                          cliinfo: '$tempss',
                          icons: desmain == 'Clouds' || desmain == 'Rain'
                              ? Icons.cloud
                              : Icons.wb_sunny_sharp,
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Additional Informations",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Addinfo(
                      degree: '$humidity',
                      climate: 'humidity',
                      icon: Icons.air,
                    ),
                    Addinfo(
                      degree: '$windspeed',
                      climate: 'Speed',
                      icon: Icons.speed,
                    ),
                    Addinfo(
                      degree: '$pressure',
                      climate: 'Pressure',
                      icon: Icons.umbrella_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
