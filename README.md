
# thermometer
A simple and customizable widget to be used as a thermometer in Flutter.

## Features

This widget will create a thermometer. 

## Getting started

- [Installation](#installation)
- [Constructor](#constructor)
- [Usage_Example](#usage-example)


### Installation

Add the following to your pubsec.yaml:

```bash
dependencies:
  thermometer:
    git:
      url:
```

And then run following command on terminal:

```bash
flutter pub get
```

### Constructor

| Property | Default | Description |
|-----------|----------|-------------|
| height |  | The height of thermometer. Width will automatically get 25% of it. |
| duration | const Duration(milliseconds: 300) | The time duration of animation of liquid when temperature is changed. |
| temperatureC |  | The temperature of thermometer in Celsius. |
| showScreenTemperatureInFahrenheit | false | To show the temperature on screen in Fahrenheit. |
| backgroundGradient| const LinearGradient(
      colors: [Colors.white, Color.fromARGB(255, 224, 224, 224)],
      stops: [0.3, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ) | Gradient which will act as background (color) of thermometer. |
| textColor | const Color.fromARGB(255, 87, 87, 87) | Text color used inside the thermometer. |
| boundaryColor | const Color.fromARGB(255, 189, 189, 189) | Color of the thermometer boundary. |
| screenColor | const Color.fromARGB(255, 224, 224, 224) | Background color of the screen area. |
| tubeColor | Colors.white | Color of the thermometer tube. |
| screenTextColor | const Color.fromARGB(255, 66, 66, 66) | Color of the temperature text displayed on the screen. |
| readingLinesColor | Colors.black | Color of the small reading lines inside the thermometer. |
| veryFreezingTemperatureColor | const Color.fromARGB(255, 10, 66, 122) | Liquid color for very low (freezing) temperatures. |
| freezingTemperatureColor | const Color.fromARGB(255, 31, 135, 221) | Liquid color for low temperatures. |
| normalTemperatureColor | const Color.fromARGB(255, 50, 167, 54) | Liquid color for normal temperatures. |
| hotTemperatureColor | const Color.fromARGB(255, 219, 200, 22) | Liquid color for high temperatures. |
| veryHotTemperatureColor | const Color.fromARGB(255, 189, 32, 21) | Liquid color for very high (hot) temperatures. |

### Usage Examples

#### Example 1
Here is a basic example.
It consists of thermometer widget and a button. On clicking button, the value of temperature changes and liquid animates from last to new temperature.

```dart
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Custom Thermometer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: height * 0.1),
          child: CustomThermometer(
            height: 400,
            temperatureC: temp,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade50,
        onPressed: _changeTemperature,
        tooltip: 'Change Temperature',
        child: Icon(Icons.star, color: Colors.grey.shade800),
      ),
    );
  }
}
```

// gif

#### Example 2
Here is another example which creates a static thermometer aiming to use different properites provided by the widget.

```dart
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final Size(:height, :width) = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: height * 0.1),
          child: CustomThermometer(
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
    );
  }
}

```

// image



