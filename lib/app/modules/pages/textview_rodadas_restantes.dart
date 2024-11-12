import 'package:flutter/material.dart';

class RodadasWidget extends StatefulWidget {
  const RodadasWidget({super.key});

  @override
  State<RodadasWidget> createState() => _RodadasWidgetState();
}

class _RodadasWidgetState extends State<RodadasWidget> {
  final int _totalRodadas = 10;
  // ignore: prefer_final_fields
  int _rodadaAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
