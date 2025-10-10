import 'package:flutter/material.dart';

class ThermometerPainter extends CustomPainter {
  static const int maxCharactersScreenTemperature = 7;
  static const String screenTextFontFamily = 'Digital7';
  final double temperatureC;
  final double animationTemperature;
  final bool showScreenTemperatureInFahrenHeit;
  final Gradient backgroundGradient;
  final Color boundaryColor;
  final Color textColor;
  final Color readingLinesColor;
  final Color tubeColor;
  final Color screenColor;
  final Color screenTextColor;
  final Color liquidColor;

  const ThermometerPainter({
    required this.temperatureC,
    required this.showScreenTemperatureInFahrenHeit,
    required this.backgroundGradient,
    required this.boundaryColor,
    required this.textColor,
    required this.readingLinesColor,
    required this.tubeColor,
    required this.screenColor,
    required this.screenTextColor,
    required this.liquidColor,
    required this.animationTemperature,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final centerWidth = width / 2;

    // Thermometer body
    final bodyPath = Path();
    bodyPath.moveTo(0, height * 0.15);
    bodyPath.conicTo(centerWidth, -height * 0.05, width, height * 0.15, 0.45);
    bodyPath.lineTo(width, height * 0.975);
    bodyPath.conicTo(width, height, width * 0.9, height, 0.7);
    bodyPath.lineTo(width * 0.1, height);
    bodyPath.conicTo(0, height, 1, height * 0.975, 0.7);
    bodyPath.lineTo(0, height * 0.15);
    final bodyPaint = Paint()
      ..shader = backgroundGradient.createShader(
        Rect.fromLTRB(0, 0, width, height),
      );
    canvas.drawPath(bodyPath, bodyPaint);

    // Thermometer body boundary
    final bodyBoundaryPaint = Paint()
      ..color = boundaryColor
      ..strokeWidth = height * 0.0035
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(bodyPath, bodyBoundaryPaint);

    // Text '°F'
    final fCTextSize = height * 0.045;
    final fTextSPan = TextSpan(
      text: '°F',
      style: TextStyle(
        color: textColor,
        fontSize: fCTextSize,
        fontWeight: FontWeight.bold,
      ),
    );
    final fTextPainter = TextPainter(
      text: fTextSPan,
      textDirection: TextDirection.ltr,
    );
    fTextPainter.layout();
    final fTextOffset = Offset(width * 0.15, height * 0.15);
    fTextPainter.paint(canvas, fTextOffset);

    // Text '°C'
    final cTextSPan = TextSpan(
      text: '°C',
      style: TextStyle(
        color: textColor,
        fontSize: fCTextSize,
        fontWeight: FontWeight.bold,
      ),
    );
    final cTextPainter = TextPainter(
      text: cTextSPan,
      textDirection: TextDirection.ltr,
    );
    cTextPainter.layout();
    final cTextOffset = Offset(width * 0.65, height * 0.15);
    cTextPainter.paint(canvas, cTextOffset);

    // Fahrenheit lines
    final cFLinePaint = Paint()
      ..color = readingLinesColor
      ..strokeWidth = height * 0.002;
    for (int i = 0; i <= 80; i++) {
      if (i % 10 == 0) {
        var offsetP1 = Offset(
          width * 0.3,
          height * 0.25 + i * (height * 0.0075),
        );
        var offsetP2 = Offset(
          width * 0.42,
          height * 0.25 + i * (height * 0.0075),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      } else if (i % 5 == 0) {
        var offsetP1 = Offset(
          width * 0.35,
          height * 0.25 + i * (height * 0.0075),
        );
        var offsetP2 = Offset(
          width * 0.42,
          height * 0.25 + i * (height * 0.0075),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      } else {
        var offsetP1 = Offset(
          width * 0.38,
          height * 0.25 + i * (height * 0.0075),
        );
        var offsetP2 = Offset(
          width * 0.42,
          height * 0.25 + i * (height * 0.0075),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      }
    }

    // Fahrenheit numbers
    final farhrenheitStartTemp = 120;
    for (int i = 0; i < 9; i++) {
      final textSpan = TextSpan(
        text: '${farhrenheitStartTemp - i * 20}',
        style: TextStyle(
          color: textColor,
          fontSize: height * 0.025,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(width * 0.1, height * 0.24 + i * (height * 0.074)),
      );
    }

    // Celsius lines
    for (int i = 0; i <= 90; i++) {
      if (i % 10 == 0) {
        var offsetP1 = Offset(
          width * 0.58,
          height * 0.25 + i * (height * 0.00666),
        );
        var offsetP2 = Offset(
          width * 0.7,
          height * 0.25 + i * (height * 0.00666),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      } else if (i % 5 == 0) {
        var offsetP1 = Offset(
          width * 0.58,
          height * 0.25 + i * (height * 0.00666),
        );
        var offsetP2 = Offset(
          width * 0.65,
          height * 0.25 + i * (height * 0.00666),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      } else {
        var offsetP1 = Offset(
          width * 0.58,
          height * 0.25 + i * (height * 0.00666),
        );
        var offsetP2 = Offset(
          width * 0.62,
          height * 0.25 + i * (height * 0.00666),
        );
        canvas.drawLine(offsetP1, offsetP2, cFLinePaint);
      }
    }

    // Celsius numbers
    final celsiusStartTemp = 50;
    for (int i = 0; i < 10; i++) {
      final textSpan = TextSpan(
        text: '${celsiusStartTemp - i * 10}',
        style: TextStyle(
          color: textColor,
          fontSize: height * 0.025,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(width * 0.8, height * 0.24 + i * (height * 0.065)),
      );
    }

    // Tube
    final tubeRect = Rect.fromLTRB(
      width * 0.46,
      height * 0.245,
      width * 0.54,
      height * 0.855,
    );
    final tubePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.grey.shade600, tubeColor],
        stops: [0, 0.4],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(tubeRect)
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRect(tubeRect, tubePaint);

    // Tube top bottom shadow
    final tubeShadowPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.grey, Colors.transparent],
        stops: [0, 0.01],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(tubeRect)
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRect(tubeRect, tubeShadowPaint);

    // Tube boundary
    final tubeBoundaryPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = height * 0.001
      ..strokeJoin = StrokeJoin.round;
    canvas.drawRect(tubeRect, tubeBoundaryPaint);

    // Liquid
    final double modifiedTemp = (animationTemperature + 40).clamp(0.5, 90);
    final heightAdjustor = 0.00675;
    final liquidHeight = -(height * modifiedTemp * heightAdjustor);
    final liquidRect = Rect.fromLTWH(
      width * 0.4675,
      height * 0.854,
      width * 0.0675,
      liquidHeight,
    );
    final liquidPaint = Paint()..color = liquidColor;
    canvas.drawRect(liquidRect, liquidPaint);

    // Temperature screen
    final screenRect = Rect.fromLTRB(
      width * 0.1,
      height * 0.88,
      width * 0.9,
      height * 0.96,
    );
    final screenPaint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..shader = LinearGradient(
        colors: [Colors.grey.shade800, screenColor, screenColor, Colors.white],
        stops: [0.0, 0.04, 0.96, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(screenRect);
    canvas.drawRect(screenRect, screenPaint);

    // Temperature screen shadow
    final screenShadowPaint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..shader = LinearGradient(
        colors: [
          Colors.grey.shade800,
          Colors.transparent,
          Colors.white.withAlpha(0),
          Colors.white,
        ],
        stops: [0.0, 0.1, 0.9, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(screenRect);
    canvas.drawRect(screenRect, screenShadowPaint);

    // Temperature screen text
    // Controlling number of characters in temperature C
    final String modifiedTemperature;
    if (showScreenTemperatureInFahrenHeit) {
      final double temperatureF = convertCelsiusToFahrenHeit(temperatureC);
      if (temperatureF.toString().length > maxCharactersScreenTemperature) {
        modifiedTemperature = temperatureF.toString().substring(0, 8);
      } else {
        modifiedTemperature = temperatureF.toString();
      }
    } else {
      if (temperatureC.toString().length > maxCharactersScreenTemperature) {
        modifiedTemperature = temperatureC.toString().substring(0, 8);
      } else {
        modifiedTemperature = temperatureC.toString();
      }
    }

    final screenTextSpan = TextSpan(
      text: showScreenTemperatureInFahrenHeit
          ? '$modifiedTemperature°F'
          : '$modifiedTemperature°C',
      style: TextStyle(
        color: screenTextColor,
        fontSize: height * 0.042,
        fontFamily: screenTextFontFamily,
      ),
    );
    final screenTextPainter = TextPainter(
      text: screenTextSpan,
      textDirection: TextDirection.ltr,
    );
    screenTextPainter.layout();
    screenTextPainter.paint(canvas, Offset(width * 0.16, height * 0.89));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    oldDelegate = oldDelegate as ThermometerPainter;
    return oldDelegate.temperatureC != temperatureC ||
        oldDelegate.animationTemperature != animationTemperature;
  }
}

double convertCelsiusToFahrenHeit(double temperature) {
  return temperature * 9 / 5 + 32;
}
