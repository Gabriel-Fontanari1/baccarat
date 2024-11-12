import 'dart:math';
import 'package:flutter/material.dart';

class CartasAnimadas extends StatefulWidget {
  final VoidCallback onTimerFinish;

  const CartasAnimadas({super.key, required this.onTimerFinish});

  @override
  // ignore: library_private_types_in_public_api
  _CartasAnimadasState createState() => _CartasAnimadasState();
}

class _CartasAnimadasState extends State<CartasAnimadas> {
  List<int> cartas = [];
  bool cartasVisiveis = false;

  void ativarCartas() {
    setState(() {
      cartasVisiveis = true;
    });
  }

  @override
  void initState() {
    super.initState();
    cartas = List.generate(2, (_) => Random().nextInt(9) + 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ativarCartas();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < cartas.length; i++)
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: cartasVisiveis ? 75.0 : -100.0,
              left: (screenWidth / 2) - 110 + (i * 120),
              child: Card(
                color: const Color.fromARGB(255, 132, 31, 150),
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: Text(
                      cartas[i].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
