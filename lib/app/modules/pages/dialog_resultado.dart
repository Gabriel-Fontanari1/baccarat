import 'package:flutter/material.dart';

class DialogResultado {
  static Future<void> mostrarResultado({
    required BuildContext context,
    required String casaGanhadora,
    required double valorGanhos,
    required bool ganhou,
  }) {
    String mensagem;
    String valorResultado;

    if (ganhou) {
      mensagem = "VITÓRIA DO $casaGanhadora !";
      valorResultado = "GANHOU ${valorGanhos.toStringAsFixed(2)}";
    } else {
      mensagem = "$casaGanhadora GANHOU!";
      valorResultado = "Você perdeu...";
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 25, 0, 51),
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                mensagem,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                valorResultado,
                style: const TextStyle(
                  color: Color.fromARGB(255, 205, 255, 0),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
