import 'dart:async';

import 'package:flutter/material.dart';

class MeditationTimerPage extends StatefulWidget {
  const MeditationTimerPage({super.key, required this.title});

  final String title;

  @override
  State<MeditationTimerPage> createState() => _MeditationTimerPageState();
}

class _MeditationTimerPageState extends State<MeditationTimerPage> {
  int timeLeft = 30;

  void _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(timeLeft == 0 ? 'D O N E' : timeLeft.toString(),
              style: TextStyle(color: Colors.white, fontSize: 50)),
          MaterialButton(
              onPressed: _startCountDown,
              child: Text('S T A R T',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              color: Colors.deepPurple)
        ],
      ),
    ));
  }
}
