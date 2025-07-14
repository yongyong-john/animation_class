import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/apple_watch_screen.dart';
import 'package:flutter_animations_masterclass/screens/container_transform_screen.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/fade_through_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_animations_masterclass/screens/rive_screen.dart';
import 'package:flutter_animations_masterclass/screens/shared_axis_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animations'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ImplicitAnimationsScreen(),
                );
              },
              child: Text('Implicit Animations'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ExplicitAnimationsScreen(),
                );
              },
              child: Text('Explicit Animations'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  AppleWatchScreen(),
                );
              },
              child: Text('Apple Watch'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  SwipingCardsScreen(),
                );
              },
              child: Text('Swiping Cards'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  MusicPlayerScreen(),
                );
              },
              child: Text('Music Player'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  RiveScreen(),
                );
              },
              child: Text('Rive'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  ContainerTransformScreen(),
                );
              },
              child: Text('Conatiner Transform'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  SharedAxisScreen(),
                );
              },
              child: Text('Shared Axis'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  FadeThroughScreen(),
                );
              },
              child: Text('Fade Through'),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
