import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() => _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;
  void _trigger() {
    _visible = !_visible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NOTE: How to Implicit or Explicit animations choices?
            // https://docs.flutter.dev/assets/images/docs/ui/animations/animation-decision-tree.png
            // TweenAnimationBuilder(
            //   // tween: Tween(begin: 10.0, end: 20.0),
            //   tween: ColorTween(begin: Colors.purple, end: Colors.red),
            //   curve: Curves.bounceInOut,
            //   duration: Duration(seconds: 2),
            //   builder: (context, value, child) {
            //     return Image.network(
            //       "https://upload.wikimedia.org/wikipedia/commons/4/4f/Dash%2C_the_mascot_of_the_Dart_programming_language.png",
            //       color: Colors.red,
            //       colorBlendMode: BlendMode.colorBurn,
            //     );
            //   },
            // ),
            AnimatedContainer(
              // NOTE: https://api.flutter.dev/flutter/animation/Curves-class.html
              curve: Curves.easeInCubic,
              duration: Duration(seconds: 2),
              width: size.width * 0.8,
              height: size.width * 0.8,
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: _visible ? Colors.red : Colors.amber,
                borderRadius: BorderRadius.circular(_visible ? 100 : 0),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: Text('Go!'),
            ),
          ],
        ),
      ),
    );
  }
}
