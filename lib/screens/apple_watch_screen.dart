import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen> with SingleTickerProviderStateMixin {
  final random = Random();
  late Animation<double> redProgress;
  late Animation<double> greenProgress;
  late Animation<double> blueProgress;

  @override
  void initState() {
    super.initState();
    // Initialize progress animations for each color with random values
    redProgress = Tween(
      begin: 0.005,
      end: random.nextDouble() * 2.0,
    ).animate(_curve);

    greenProgress = Tween(
      begin: 0.005,
      end: random.nextDouble() * 2.0,
    ).animate(_curve);

    blueProgress = Tween(
      begin: 0.005,
      end: random.nextDouble() * 2.0,
    ).animate(_curve);
  }

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  void _animateValues() {
    setState(() {
      // Assign new random values to each progress
      redProgress = Tween(
        begin: redProgress.value,
        end: random.nextDouble() * 2.0,
      ).animate(_curve);

      greenProgress = Tween(
        begin: greenProgress.value,
        end: random.nextDouble() * 2.0,
      ).animate(_curve);

      blueProgress = Tween(
        begin: blueProgress.value,
        end: random.nextDouble() * 2.0,
      ).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Apple Watch"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([redProgress, greenProgress, blueProgress]),
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(
                redProgress: redProgress.value,
                greenProgress: greenProgress.value,
                blueProgress: blueProgress.value,
              ),
              size: Size(400, 400),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double redProgress;
  final double greenProgress;
  final double blueProgress;

  AppleWatchPainter({
    required this.redProgress,
    required this.greenProgress,
    required this.blueProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final startingAngle = -0.5 * pi;

    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final redCircleRadius = (size.width / 2) * 0.9;

    canvas.drawCircle(
      center,
      redCircleRadius,
      redCirclePaint,
    );

    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final greenCircleRadius = (size.width / 2) * 0.76;

    canvas.drawCircle(
      center,
      greenCircleRadius,
      greenCirclePaint,
    );

    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.cyan.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final blueCircleRadius = (size.width / 2) * 0.62;

    canvas.drawCircle(
      center,
      blueCircleRadius,
      blueCirclePaint,
    );

    // red arc
    final redArcRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );

    final redArcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      redProgress * pi,
      false,
      redArcPaint,
    );

    // green arc
    final greenArcRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );

    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      greenArcRect,
      startingAngle,
      greenProgress * pi,
      false,
      greenArcPaint,
    );

    // blue arc
    final blueArcRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );

    final blueArcPaint = Paint()
      ..color = Colors.cyan.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      blueArcRect,
      startingAngle,
      blueProgress * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.redProgress != redProgress ||
        oldDelegate.greenProgress != greenProgress ||
        oldDelegate.blueProgress != blueProgress;
  }
}
