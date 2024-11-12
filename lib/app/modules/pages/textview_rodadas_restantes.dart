import 'package:flutter/material.dart';

class RodadasWidget extends StatefulWidget {
  final VoidCallback onNewRound;

  const RodadasWidget({super.key, required this.onNewRound});

  @override
  State<RodadasWidget> createState() => _RodadasWidgetState();
}

class _RodadasWidgetState extends State<RodadasWidget> {
  final int _totalRodadas = 10;
  int _rodadaAtual = 0;

  void iniciarNovoRound() {
    if (_rodadaAtual < _totalRodadas) {
      setState(() {
        _rodadaAtual++;
      });
      widget.onNewRound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: iniciarNovoRound,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Rodadas restantes: ${_totalRodadas - _rodadaAtual}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
