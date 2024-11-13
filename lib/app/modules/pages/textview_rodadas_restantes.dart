import 'package:flutter/material.dart';

class RodadasWidget extends StatelessWidget {
  final VoidCallback onNewRound;
  final int roundsRestantes;

  const RodadasWidget({
    super.key,
    required this.onNewRound,
    required this.roundsRestantes,
  });

  //textview rodadas restantes
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNewRound, // Inicia a nova rodada ao clicar
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Rodadas restantes: $roundsRestantes',
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
