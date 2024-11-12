import 'package:baccarat/app/modules/pages/bets_values.dart';
import 'package:baccarat/app/modules/pages/casa_jogador_tie.dart';
import 'package:baccarat/app/modules/pages/textview_rodadas_restantes.dart';
import 'package:baccarat/app/modules/pages/textviews_saldo_aposta.dart';
import 'package:baccarat/app/modules/pages/timer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  int _saldo = 0;
  bool _showInputAndButton = true;
  bool _showTimer = false;

  void _adicionarSaldo() {
    final saldoInserido = int.tryParse(_controller.text);
    if (saldoInserido != null && saldoInserido > 0) {
      setState(() {
        _saldo += saldoInserido;
        _showInputAndButton = false;
        _showTimer = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, insira um valor válido")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (_showInputAndButton) ...[
                TextBoxValorParaApostar(controller: _controller),
                ButtonJogar(onPressed: _adicionarSaldo),
              ],
              if (_showTimer)
                const TimerWidget(),
              const InserirApostaCasaJogadorTie(),
              const BottonsAdicionarAposta(),
              const TextViewSuaAposta(),
              TextViewSeuSaldo(saldo: _saldo),
            ],
          ),
          const Positioned(
            top: 20,
            right: 20,
            child: RodadasWidget(), 
          ),
        ],
      ),
    );
  }
}

class ButtonJogar extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonJogar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 100),
            backgroundColor: const Color.fromARGB(255, 93, 26, 124),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'JOGAR',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class TextBoxValorParaApostar extends StatelessWidget {
  final TextEditingController controller;

  const TextBoxValorParaApostar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Valor para apostar',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 300,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '500',
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 117, 47, 163)),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ],
      ),
    );
  }
}
