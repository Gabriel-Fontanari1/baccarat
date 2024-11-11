import 'package:flutter/material.dart';

class InserirApostaCasaJogadorTie extends StatefulWidget {
  const InserirApostaCasaJogadorTie({super.key});

  @override
  State<InserirApostaCasaJogadorTie> createState() =>
      _InserirApostaCasaJogadorTieState();
}

class _InserirApostaCasaJogadorTieState
    extends State<InserirApostaCasaJogadorTie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 245, 242, 242),
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.4,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildButton('PLAYER', '1:1'),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _buildButton('BANKER', '0.95:1'),
              ),
            ],
          ),
          Positioned(
            child: _buildCenterButton('TIE', '8:1', width: 120),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, String odds) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 55, 21, 110),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            odds,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton(String text, String odds, {double width = 80}) {
    return Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 103, 71, 158),
        border: Border.all(
            color: const Color.fromARGB(255, 243, 240, 240), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            odds,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
