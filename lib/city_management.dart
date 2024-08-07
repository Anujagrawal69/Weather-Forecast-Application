import 'package:flutter/material.dart';
import 'package:weather_app/home.dart';

class CityManagement extends StatefulWidget {
  const CityManagement({super.key});

  @override
  State<CityManagement> createState() {
    return _CityManagementState();
  }
}

class _CityManagementState extends State<CityManagement> {
  TextEditingController searchData = TextEditingController();
  void _chooseCity() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      context: context,
      builder: (ctx) {
        return Container(
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
          width: double.infinity,
          height: 400,
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 30,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Enter City Name',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    controller: searchData,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: _search,
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(93, 212, 212, 212)),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _search() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          cityName: searchData.text,
        ),
      ),
    );
    print(searchData.text.toString());
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 6, 1, 33),
            Color.fromARGB(255, 3, 12, 75),
            Color.fromARGB(255, 7, 1, 39),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        width: double.infinity,
        child: SafeArea(
          child: Column(children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextButton(
                onPressed: _chooseCity,
                child: const Text(
                  'Choose City',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
              color: Color.fromARGB(122, 90, 90, 90),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Temperature Types will be added later",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
