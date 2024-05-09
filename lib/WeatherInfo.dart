import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final String degree;
  final IconData icons;
  final String cliinfo;
  const WeatherInfo(
      {Key? key,
      required this.degree,
      required this.icons,
      required this.cliinfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                degree,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Icon(
                icons,
                size: 25,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                cliinfo,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
