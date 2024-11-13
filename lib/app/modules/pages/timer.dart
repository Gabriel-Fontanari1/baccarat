import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final VoidCallback onTimerFinish; //função chamada no final do timer
  const TimerWidget({super.key, required this.onTimerFinish});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _timeLeft = 5; //tempo do timer
  double _progress = 1.0; //progresso visual do temporizador
  late Timer _timer;
  bool _timerVisivel = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  //timer vai decrementar a cada segundo
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
          _progress = _timeLeft / 5; //atualiza o progresso visual
        } else {
          _timer.cancel(); //cancelar o timer
          _timerVisivel = false;
          widget.onTimerFinish();
        }
      });
    });
  }

  //cancela o timer para evitar vazamento de memoria
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
        : Container(); //se o timer estiver invisivel, ele vai só retornar um container vazio
  }
}
