import 'package:flutter/material.dart';
import 'package:thermometer_widget/src/thermometer_painter.dart';

class Thermometer extends StatefulWidget {
  final double height;
  final Duration duration;
  final double temperatureC;
  final Gradient backgroundGradient;
  final Color textColor;
  final Color boundaryColor;
  final Color readingLinesColor;
  final Color tubeColor;
  final Color screenColor;
  final Color screenTextColor;
  final Color veryFreezingTemperatureColor;
  final Color freezingTemperatureColor;
  final Color normalTemperatureColor;
  final Color hotTemperatureColor;
  final Color veryHotTemperatureColor;
  final bool showScreenTemperatureInFahrenHeit;

  const Thermometer({
    super.key,
    required this.height,
    this.duration = const Duration(milliseconds: 300),
    required this.temperatureC,
    this.backgroundGradient = const LinearGradient(
      colors: [Colors.white, Color.fromARGB(255, 224, 224, 224)],
      stops: [0.3, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    this.textColor = const Color.fromARGB(255, 87, 87, 87),
    this.boundaryColor = const Color.fromARGB(255, 189, 189, 189),
    this.screenColor = const Color.fromARGB(255, 224, 224, 224),
    this.tubeColor = Colors.white,
    this.screenTextColor = const Color.fromARGB(255, 66, 66, 66),
    this.readingLinesColor = Colors.black,
    this.veryFreezingTemperatureColor = const Color.fromARGB(255, 10, 66, 122),
    this.freezingTemperatureColor = const Color.fromARGB(255, 31, 135, 221),
    this.normalTemperatureColor = const Color.fromARGB(255, 50, 167, 54),
    this.hotTemperatureColor = const Color.fromARGB(255, 219, 200, 22),
    this.veryHotTemperatureColor = const Color.fromARGB(255, 189, 32, 21),
    this.showScreenTemperatureInFahrenHeit = false,
  });

  @override
  State<StatefulWidget> createState() {
    return ThermometerState();
  }
}

class ThermometerState extends State<Thermometer>
    with SingleTickerProviderStateMixin {
  late AnimationController _liquidAnimationController;
  late Animation _liquidAnimation;
  late Color _color;
  double _currentValueLiquidAnimation = 0.0;

  @override
  void initState() {
    super.initState();
    _liquidAnimationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() {
              _currentValueLiquidAnimation = _liquidAnimation.value;
            });
          });
  }

  @override
  void dispose() {
    _liquidAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thermometerHeight = widget.height;
    final thermometerWidth = widget.height * 0.25;

    _liquidAnimation = Tween(
      begin: _currentValueLiquidAnimation,
      end: widget.temperatureC,
    ).animate(_liquidAnimationController);
    _liquidAnimationController.forward(from: 0.0);

    if (widget.temperatureC <= _TemperatureRanges.veryFreezingTemperatureMax) {
      _color = widget.veryFreezingTemperatureColor;
    } else if (widget.temperatureC <=
        _TemperatureRanges.freezingTemperatureMax) {
      _color = widget.freezingTemperatureColor;
    } else if (widget.temperatureC <= _TemperatureRanges.normalTemperatureMax) {
      _color = widget.normalTemperatureColor;
    } else if (widget.temperatureC <= _TemperatureRanges.hotTemperatureMax) {
      _color = widget.hotTemperatureColor;
    } else {
      _color = widget.veryHotTemperatureColor;
    }

    return SizedBox(
      height: thermometerHeight,
      width: thermometerWidth,
      child: CustomPaint(
        painter: ThermometerPainter(
          temperatureC: widget.temperatureC,
          animationTemperature: _liquidAnimation.value,
          showScreenTemperatureInFahrenHeit:
              widget.showScreenTemperatureInFahrenHeit,
          backgroundGradient: widget.backgroundGradient,
          boundaryColor: widget.boundaryColor,
          textColor: widget.textColor,
          readingLinesColor: widget.readingLinesColor,
          tubeColor: widget.tubeColor,
          screenColor: widget.screenColor,
          screenTextColor: widget.screenTextColor,
          liquidColor: _color,
        ),
        size: Size(thermometerWidth, thermometerHeight),
      ),
    );
  }
}

class _TemperatureRanges {
  static const double veryFreezingTemperatureMax = -20;
  static const double freezingTemperatureMax = 0;
  static const double normalTemperatureMax = 10;
  static const double hotTemperatureMax = 30;
}
