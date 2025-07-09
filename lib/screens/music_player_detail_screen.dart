import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int index;
  const MusicPlayerDetailScreen({super.key, required this.index});

  @override
  State<MusicPlayerDetailScreen> createState() => _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final AnimationController _marqueeController;
  late final AnimationController _playPauseController;
  late final AnimationController _menuController;

  late final Curve _menuCurve = Curves.easeInOutCubic;

  late final Animation<double> _screenScale = Tween<double>(
    begin: 1.0,
    end: 0.7,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.0,
        0.3,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.5, 0),
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.2,
        0.4,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<double> _closeButtonOpacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.3,
        0.5,
        curve: _menuCurve,
      ),
    ),
  );

  late final List<Animation<Offset>> _menuAnimations = [
    for (var i = 0; i < _menu.length; i++)
      Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _menuController,
          curve: Interval(
            0.4 + (0.1 * i),
            0.7 + (0.1 * i),
            curve: _menuCurve,
          ),
        ),
      ),
  ];

  late final Animation<Offset> _logoutAnimation = Tween<Offset>(
    begin: Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.8,
        1.0,
        curve: _menuCurve,
      ),
    ),
  );

  double _textWidth = 0;
  final double _gap = 100;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 1),
    )..repeat(
        reverse: true,
      );

    _marqueeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _textKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _textWidth = renderBox.size.width;
      });
    });

    _playPauseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _menuController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      reverseDuration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _marqueeController.dispose();
    _progressController.dispose();
    _playPauseController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  void _onPlayPauseTap() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  bool _isDragging = false;

  void _toggleDragging() {
    setState(() {
      _isDragging = !_isDragging;
    });
  }

  final ValueNotifier<double> _volume = ValueNotifier(0);
  late final size = MediaQuery.of(context).size;

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;
    _volume.value = _volume.value.clamp(
      0,
      size.width - 80,
    );
  }

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  final List<Map<String, dynamic>> _menu = [
    {
      "icon": Icons.person,
      "text": "Profile",
    },
    {
      "icon": Icons.notifications,
      "text": "Notifications",
    },
    {
      "icon": Icons.settings,
      "text": "Settings",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final totalWidth = _textWidth + _gap;
    final dx = -totalWidth * _marqueeController.value;
    return Stack(
      children: [
        FadeTransition(
          opacity: _closeButtonOpacity,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              leading: IconButton(
                onPressed: _closeMenu,
                icon: Icon(Icons.close),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  for (int i = 0; i < _menu.length; i++) ...[
                    SlideTransition(
                      position: _menuAnimations[i],
                      child: Row(
                        children: [
                          Icon(
                            _menu[i]["icon"],
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _menu[i]["text"],
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                  Spacer(),
                  SlideTransition(
                    position: _logoutAnimation,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Music Player'),
                actions: [
                  IconButton(
                    onPressed: _openMenu,
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: "${widget.index}",
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/covers/${widget.index}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) => CustomPaint(
                      size: Size(size.width - 80, 5),
                      painter: ProgressBar(
                        progressValue: _progressController.value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '0:00',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '1:00',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Interstellar",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (_textWidth > 0)
                    ClipRect(
                      child: SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Stack(
                          children: [
                            // 첫 번째 텍스트
                            Positioned(
                              left: dx,
                              child: Text(
                                "A Film By Christoper Nolan - Original Motion Picture Soundtrack",
                                key: _textKey,
                                style: TextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            // 두 번째 텍스트 (첫 번째 텍스트 끝 + gap 위치)
                            Positioned(
                              left: dx + totalWidth,
                              child: Text(
                                "A Film By Christoper Nolan - Original Motion Picture Soundtrack",
                                style: TextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    // 아직 측정 전엔 키만 달아둔 텍스트 하나만 렌더
                    Text(
                      "A Film By Christoper Nolan - Original Motion Picture Soundtrack",
                      key: _textKey,
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: _onPlayPauseTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _playPauseController,
                          size: 60,
                        ),
                        // LottieBuilder.asset(
                        //   "assets/animations/play-lottie.json",
                        //   controller: _playPauseController,
                        //   onLoaded: (composition) {
                        //     _playPauseController.duration = composition.duration;
                        //   },
                        //   width: 200,
                        //   height: 200,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: _onVolumeDragUpdate,
                    onHorizontalDragStart: (_) => _toggleDragging(),
                    onHorizontalDragEnd: (_) => _toggleDragging(),
                    child: AnimatedScale(
                      scale: _isDragging ? 1.1 : 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder: (context, value, child) => CustomPaint(
                            size: Size(size.width - 80, 50),
                            painter: VolumePainter(volume: value),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    // track
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);

    // thumb

    canvas.drawCircle(Offset(progress, size.height / 2), 10, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}

class VolumePainter extends CustomPainter {
  final double volume;

  VolumePainter({
    required this.volume,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade300;

    final bgRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;

    final volumeRect = Rect.fromLTWH(
      0,
      0,
      volume,
      size.height,
    );

    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
