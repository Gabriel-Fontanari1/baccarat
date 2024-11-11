import 'package:flutter/material.dart';

class GameLayout extends StatefulWidget {
  const GameLayout({super.key});

  @override
  State<GameLayout> createState() => _GameLayoutState();
}

class _GameLayoutState extends State<GameLayout> {
  @override
  Widget build(BuildContext context) {
    return const InserirApostaCasaJogadorTie();
  }
}

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
      color: Colors.deepPurple[900],
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.8,
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
              const SizedBox(width: 16), 
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
        color: Colors.deepPurple[700],
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
      width: width,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple[400],
        border: Border.all(color: Colors.white, width: 2),
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


class BottonsAdicionarAposta extends StatefulWidget {
  const BottonsAdicionarAposta({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottonsAdicionarApostaState createState() => _BottonsAdicionarApostaState();
}

class _BottonsAdicionarApostaState extends State<BottonsAdicionarAposta> {
  final List<int> _valorAposta = [5, 10, 30, 125, 500, 1000];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(_valorAposta.length, (index) {
          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(0, 60), 
            ),
            child: Text('${_valorAposta[index]}'),
          );
        }),
      ),
    );
  }
}

class TextViewSuaAposta extends StatefulWidget {
  //este textview vai ficar na esquerda inferior da tela, mostrando o quanto o usuario aposto
  const TextViewSuaAposta({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextViewSuaApostaState createState() => _TextViewSuaApostaState();
}

class _TextViewSuaApostaState extends State<TextViewSuaAposta> {
  int totalApostado = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.purple, width: 2),
            borderRadius: BorderRadius.circular(30), 
          ),
          child: Text(
            'APOSTA: ${totalApostado > 0 ? '\$' : ''}$totalApostado',
            style: const TextStyle(
              color: Colors.purple, 
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
      ),
    );
  }
}

//textview saldo vai ter o layout semelhante ao do textview sua aposta
class TextViewSeuSaldo extends StatefulWidget {
  const TextViewSeuSaldo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextViewSeuSaldoState createState() => _TextViewSeuSaldoState();
}

class _TextViewSeuSaldoState extends State<TextViewSeuSaldo> { 
  int saldo = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.purple, width: 2),
            borderRadius: BorderRadius.circular(30), 
          ),
          child: Text(
            'SALDO: ${saldo == 0 ? '' : '\$'}$saldo',
            style: const TextStyle(
              color: Colors.purple, 
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
      ),
    );
  }
}
