import 'package:flutter/material.dart';
import 'package:thermometer_widget/thermometer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double temp = -10.39;
  int counter = 1;

  List<double> temps = [-10.39, 40, 4.5, -39.33, 25.44,];

  void _changeTemperature() {
    setState(() {
      temp = temps[counter];
      counter++;
      if (counter == 5) {
        counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size(:height, :width) = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: height * 0.1),
          child: Thermometer(
            height: 450,
            temperatureC: 25,
            showScreenTemperatureInFahrenHeit: true,
            backgroundGradient: LinearGradient(
              colors: [Colors.grey.shade400, Colors.grey.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boundaryColor: Colors.grey.shade600,
            duration: const Duration(milliseconds: 400),
            screenColor: Colors.grey.shade100,
            screenTextColor: Colors.red,
            readingLinesColor: Colors.white,
            textColor: Colors.white,
            tubeColor: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade50,
        onPressed: _changeTemperature,
        tooltip: 'Change Temperature',
        child: Icon(Icons.star, color: Colors.grey.shade800),
      )
    );
  }
}






