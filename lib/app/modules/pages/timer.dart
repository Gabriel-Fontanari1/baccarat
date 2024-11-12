import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final VoidCallback onTimerFinish;
  const TimerWidget({super.key, required this.onTimerFinish});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _timeLeft = 5;
  double _progress = 1.0;
  late Timer _timer;
  bool _timerVisivel = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
          _progress = _timeLeft / 5;
        } else {
          _timer.cancel();
          _timerVisivel = false;
          widget.onTimerFinish();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _timerVisivel
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_timeLeft',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 123, 1, 145),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 15,
                    backgroundColor: Colors.grey[300],
                    color: const Color.fromARGB(255, 123, 1, 145),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'FAÇA SUA APOSTA!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 123, 1, 145),
                ),
              ),
            ],
          )
        : Container();
  }
}
