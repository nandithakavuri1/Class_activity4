//Nanditha_Kavuri
//Sarvani_Tirumalasetti
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: HeartbeatApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class HeartbeatApp extends StatefulWidget {
  @override
  _HeartbeatAppState createState() => _HeartbeatAppState();
}

class _HeartbeatAppState extends State<HeartbeatApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  int _countdown = 10;
  List<String> greetings = [
    "Happy Valentine's Day!",
    "You make my heart beat faster!",
    "Love is in the air!",
    "You're my heartbeat!"
  ];
  int _currentGreetingIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[50],
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 100,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _countdown % 2 == 0 ? 1.0 : 0.0,
                    duration: Duration(seconds: 1),
                    child: Text(
                      greetings[_currentGreetingIndex],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildFloatingHearts(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingHearts() {
    return Positioned.fill(
      child: Stack(
        children: List.generate(10, (index) {
          final random = Random();
          return AnimatedPositioned(
            duration: Duration(seconds: random.nextInt(5) + 3),
            bottom: random.nextDouble() * 100,
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            child: Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
              size: random.nextInt(30) + 20.0,
            ),
          );
        }),
      ),
    );
  }
}