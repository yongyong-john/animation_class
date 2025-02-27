import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() => _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
    reverseDuration: Duration(seconds: 1),
  )..addListener(() {
      _range.value = _animationController.value;
    });
  // NOTE: AnimationStatus를 통해 상태를 확인 가능
  // ..addStatusListener(
  //   (status) {
  //     if (status == AnimationStatus.completed) {
  //       _animationController.reverse();
  //     } else if (status == AnimationStatus.dismissed) {
  //       _animationController.forward();
  //     }
  //   });

  // late final Animation<Color?> _color = ColorTween(
  //   begin: Colors.amber,
  //   end: Colors.red,
  // ).animate(_animationController);

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(120),
    ),
  ).animate(_curve);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_curve);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_curve);

  late final Animation<Offset> _offset = Tween(
    begin: Offset.zero,
    // NOTE: 전체 크기의 상대적인 움직임
    end: Offset(0, -0.2),
  ).animate(_curve);

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticInOut,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  final ValueNotifier<double> _range = ValueNotifier(0.0);

  void _onChanged(double value) {
    _range.value = 0;
    _animationController.value = value;
    // NOTE: Controller를 통해 Animation을 한 번에 값으로 적용하는 방법
    // _animationController.animateTo(value);
  }

  bool _looping = false;

  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      _animationController.repeat(reverse: true);
    }
    setState(() {
      _looping = !_looping;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NOTE: https://docs.flutter.dev/ui/widgets/animation
            // Animated... = implicit animation functions
            // ...Transition = explicit animation functions
            // 가능하면 Animated을 사용하여 구현하는 것이 간편하고 좋다.
            // AnimatedBuilder(
            //   animation: _color,
            //   builder: (context, child) {
            //     return Container(
            //       color: _color.value,
            //       width: 400,
            //       height: 400,
            //     );
            //   },
            // ),
            SlideTransition(
              position: _offset,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _play,
                  child: Text('Play'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _pause,
                  child: Text('Pause'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _rewind,
                  child: Text('Rewind'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _toggleLooping,
                  child: Text(
                    _looping ? "Stop looping" : "Start looping",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            // NOTE: setState 대신 ValueNotifier를 사용한 최적화
            ValueListenableBuilder(
              valueListenable: _range,
              builder: (context, value, child) {
                return Slider(
                  value: _range.value,
                  onChanged: _onChanged,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
