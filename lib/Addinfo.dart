import 'package:flutter/material.dart';

class Addinfo extends StatelessWidget {
  final String degree;

  final IconData icon;

  final String climate;

  const Addinfo(
      {Key? key,
      required this.degree,
      required this.icon,
      required this.climate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                degree,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Icon(
                icon,
                size: 25,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                climate,
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
