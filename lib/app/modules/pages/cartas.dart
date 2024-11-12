import 'package:flutter/material.dart';

class CartasAnimadas extends StatefulWidget {
  final VoidCallback onTimerFinish;

  const CartasAnimadas({super.key, required this.onTimerFinish});

  @override
  // ignore: library_private_types_in_public_api
  _CartasAnimadasState createState() => _CartasAnimadasState();
}

class _CartasAnimadasState extends State<CartasAnimadas> {
  List<int> cartas = List.generate(9, (index) => index + 1);
  List<double> posicoesCartas = List.generate(9, (index) => -100.0);
  bool cartasVisiveis = false;

  // Ativa a animação das cartas
  void ativarCartas() {
    setState(() {
      cartasVisiveis = true;
      for (int i = 0; i < cartas.length; i++) {
        posicoesCartas[i] = 20.0 + (i * 60.0); // Movendo as cartas para dentro da tela
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Chamando a função onTimerFinish quando as cartas são ativadas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!cartasVisiveis) {
        widget.onTimerFinish(); // Chama a função para avisar que o timer terminou
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animação das cartas
          for (int i = 0; i < cartas.length; i++)
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: cartasVisiveis ? posicoesCartas[i] : -100.0,
              left: 20.0,
              right: 20.0,
              child: Card(
                color: Colors.purple,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: Text(
                      cartas[i].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
