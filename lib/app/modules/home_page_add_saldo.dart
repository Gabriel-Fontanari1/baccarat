import 'package:baccarat/app/modules/pages/cartas.dart';
import 'package:flutter/material.dart';
import 'package:baccarat/app/modules/pages/timer.dart';
import 'package:baccarat/app/modules/pages/casa_jogador_tie.dart';
import 'package:baccarat/app/modules/pages/textviews_saldo_aposta.dart';
import 'package:baccarat/app/modules/pages/bets_values.dart';
import 'package:baccarat/app/modules/pages/textview_rodadas_restantes.dart';

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
  bool _showCartas = false;
  bool timerAtivo = true;
  int? _valorApostaSelecionado;

  int _playerAposta = 0;
  int _bankerAposta = 0;
  int _tieAposta = 0;
  int _totalApostado = 0;

  void _adicionarSaldo() {
    final saldoInserido = int.tryParse(_controller.text);
    if (saldoInserido != null && saldoInserido > 0) {
      setState(() {
        _saldo += saldoInserido;
        _showInputAndButton = false;
        _showTimer = true;
        timerAtivo = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, insira um valor válido")),
      );
    }
  }

  void _ativarCartas() {
    setState(() {
      _showTimer = false;
      _showCartas = true;
      timerAtivo = false;
    });
  }

  void _selecionarValorAposta(int valor) {
    setState(() {
      _valorApostaSelecionado = valor;
    });
  }

  void _adicionarApostaNaCasa(String casa) {
    if (!timerAtivo) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O tempo de aposta acabou")),
      );
      return;
    }

    if (_valorApostaSelecionado != null && _valorApostaSelecionado! <= _saldo) {
      setState(() {
        _saldo -= _valorApostaSelecionado!;
        _totalApostado += _valorApostaSelecionado!;

        if (casa == 'PLAYER') {
          _playerAposta += _valorApostaSelecionado!;
        } else if (casa == 'BANKER') {
          _bankerAposta += _valorApostaSelecionado!;
        } else if (casa == 'TIE') {
          _tieAposta += _valorApostaSelecionado!;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saldo insuficiente para essa aposta")),
      );
    }
  }

  void _zerarApostas() {
    setState(() {
      _playerAposta = 0;
      _bankerAposta = 0;
      _tieAposta = 0;
      _totalApostado = 0;
      _showCartas = false;
      _showTimer = true;
      timerAtivo = true;
    });
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
              if (_showTimer) TimerWidget(onTimerFinish: _ativarCartas),
              if (_showCartas) CartasAnimadas(onTimerFinish: () {}),
              InserirApostaCasaJogadorTie(
                playerAposta: _playerAposta,
                bankerAposta: _bankerAposta,
                tieAposta: _tieAposta,
                onSelecionarCasa: _adicionarApostaNaCasa,
              ),
              BottonsAdicionarAposta(
                onSelecionarValor: _selecionarValorAposta,
              ),
              TextViewSuaAposta(totalApostado: _totalApostado),
              TextViewSeuSaldo(saldo: _saldo),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            child: RodadasWidget(onNewRound: _zerarApostas),
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
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
