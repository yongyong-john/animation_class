import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/animations/balls-animation.riv',
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: RiveAnimation.asset(
                'assets/animations/custom-button-animation.riv',
                stateMachines: ["state"],
              ),
            ),
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
