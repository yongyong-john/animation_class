import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _index = 0;

  void _onNewDestination(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fade Through'),
      ),
      body: PageTransitionSwitcher(
        duration: Duration(seconds: 1),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) => FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: [
          NavigationPage(
            key: ValueKey(0),
            text: "Profile",
            icon: Icons.person,
          ),
          NavigationPage(
            key: ValueKey(1),
            text: "Notifications",
            icon: Icons.notifications,
          ),
          NavigationPage(
            key: ValueKey(2),
            text: "Settings",
            icon: Icons.settings,
          ),
        ][_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNewDestination,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: "Notifications",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class NavigationPage extends StatelessWidget {
  final String text;
  final IconData icon;
  const NavigationPage({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 180,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
