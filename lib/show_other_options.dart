import 'package:flutter/material.dart';
import 'package:weather_app/city_management.dart';

class ShowOtherOptions extends StatefulWidget {
  const ShowOtherOptions({super.key});

  @override
  State<ShowOtherOptions> createState() => _ShowOtherOptionsState();
}

class _ShowOtherOptionsState extends State<ShowOtherOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 6, 1, 33),
            Color.fromARGB(255, 3, 12, 75),
            Color.fromARGB(255, 7, 1, 39),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CityManagement(),
                  ),
                );
              },
              child: const Text(
                "Settings",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 90, 90, 90),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Share",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
