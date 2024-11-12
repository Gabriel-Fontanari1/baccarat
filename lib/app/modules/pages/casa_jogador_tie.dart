import 'package:flutter/material.dart';

class InserirApostaCasaJogadorTie extends StatelessWidget {
  final int playerAposta;
  final int bankerAposta;
  final int tieAposta;
  final Function(String) onSelecionarCasa;

  const InserirApostaCasaJogadorTie({
    super.key,
    required this.playerAposta,
    required this.bankerAposta,
    required this.tieAposta,
    required this.onSelecionarCasa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 247, 247),
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
                child: _buildButton('PLAYER 1:1', playerAposta, 'PLAYER'),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _buildButton('BANKER 0.95:1', bankerAposta, 'BANKER'),
              ),
            ],
          ),
          Positioned(
            child: _buildCenterButton('TIE 8:1', tieAposta, 'TIE', width: 120),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, int aposta, String casa) {
    return GestureDetector(
      onTap: () => onSelecionarCasa(casa),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 55, 21, 110),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            if (aposta > 0)
              Text(
                '$aposta',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton(String text, int aposta, String casa,
      {double width = 80}) {
    return GestureDetector(
      onTap: () => onSelecionarCasa(casa),
      child: Container(
        width: 150,
        height: 150,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 103, 71, 158),
          border: Border.all(
              color: const Color.fromARGB(255, 243, 240, 240), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              if (aposta > 0)
                Text(
                  '$aposta',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
