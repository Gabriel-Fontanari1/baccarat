import 'package:baccarat/app/modules/pages/casa_jogador_tie.dart';
import 'package:baccarat/app/modules/pages/bets_values.dart';
import 'package:baccarat/app/modules/pages/textviews_saldo_aposta.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Scaffold build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          TextBoxValorParaApostar(),
          ButtonJogar(),
          InserirApostaCasaJogadorTie(),
          BottonsAdicionarAposta(),
          TextViewSuaAposta(),
          TextViewSeuSaldo(),
        ],
      ),
    );
  }
}

class ButtonJogar extends StatelessWidget {
  const ButtonJogar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
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
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class TextBoxValorParaApostar extends StatelessWidget {
  const TextBoxValorParaApostar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

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
            width: 300, // Increased width
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
