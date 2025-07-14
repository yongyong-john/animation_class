import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _currentImage = 1;

  void _goToImage(int newImage) {
    setState(() {
      _currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Axis'),
      ),
      body: Column(
        children: [
          PageTransitionSwitcher(
            duration: Duration(seconds: 1),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) => SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            ),
            child: Container(
              key: ValueKey(_currentImage),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/covers/$_currentImage.jpg"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var btn in [1, 2, 3, 4, 5])
                ElevatedButton(
                  onPressed: () => _goToImage(btn),
                  child: Text('$btn'),
                ),
            ],
          )
        ],
      ),
    );
  }
}
