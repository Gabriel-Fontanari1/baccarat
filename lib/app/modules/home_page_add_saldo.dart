import 'package:baccarat/app/modules/pages/cartas.dart';
import 'package:baccarat/app/modules/pages/dialog_resultado.dart';
import 'package:baccarat/app/modules/pages/dialog_saldoinsuficiente.dart';
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
  //definição de variaveis
  int _saldo = 0;
  bool _showInputAndButton = true;
  bool _showTimer = false;
  bool _showCartas = false;
  bool timerAtivo = true;
  int? _valorApostaSelecionado;
  int _roundsRestantes = 10;
  int _playerAposta = 0;
  int _bankerAposta = 0;
  int _tieAposta = 0;
  int _totalApostado = 0;

  //add saldo e ativa o timer
  void _adicionarSaldo() {
    final saldoInserido = int.tryParse(_controller.text);
    if (saldoInserido != null && saldoInserido > 0) {
      setState(() {
        _saldo += saldoInserido;
        _showInputAndButton =
            false; //oculta o botão e o inputtext para add saldo
        _showTimer = true;
        timerAtivo = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, insira um valor válido")),
      );
    }
  }

  //puxa as cartas e desativa o timer
  void _ativarCartas() {
    setState(() {
      _showTimer = false;
      _showCartas = true;
      timerAtivo = false;
    });
  }

  //selecionar o valor da aposta
  void _selecionarValorAposta(int valor) {
    setState(() {
      _valorApostaSelecionado = valor;
    });
  }

  //add aposta nas casas, durante durante o timer
  void _adicionarApostaNaCasa(String casa) {
    if (!timerAtivo) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O tempo de aposta acabou")),
      );
      return;
    }

    if (_valorApostaSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, selecione um valor para a aposta")),
      );
      return;
    }

    if (_valorApostaSelecionado! > _saldo) {
      DialogSaldoInsuficiente.mostrarDialogSaldoInsuficiente(context);
      return;
    }

    //atualiza as apostas com o valor selecionado
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
  }

  //puxar o proximo round
  void _zerarApostas() {
    setState(() {
      _playerAposta = 0;
      _bankerAposta = 0;
      _tieAposta = 0;
      _totalApostado = 0;
      _showCartas = false;
      _showTimer = true;
      timerAtivo = true;

      if (_roundsRestantes > 0) {
        _roundsRestantes--;
      }
    });
  }

  //calcula o resultado conforme as cartas
  void _calcularGanho(int cartaEsquerda, int cartaDireita) async {
    const double multiplicadorPlayer = 2.0;
    const double multiplicadorBanker = 1.95;
    const double multiplicadorTie = 8.0;

    setState(() {
      timerAtivo = false;
    });

    String casaGanhadora;
    double valorGanhos = 0;
    bool ganhou = false;

    //verifica o vencedor
    if (cartaEsquerda > cartaDireita && _playerAposta > 0) {
      valorGanhos = (_playerAposta * multiplicadorPlayer);
      ganhou = true;
      casaGanhadora = 'PLAYER';
      _saldo += valorGanhos.toInt();
    } else if (cartaDireita > cartaEsquerda && _bankerAposta > 0) {
      valorGanhos = (_bankerAposta * multiplicadorBanker);
      ganhou = true;
      casaGanhadora = 'BANKER';
      _saldo += valorGanhos.toInt();
    } else if (cartaEsquerda == cartaDireita && _tieAposta > 0) {
      valorGanhos = (_tieAposta * multiplicadorTie);
      ganhou = true;
      casaGanhadora = 'TIE';
      _saldo += valorGanhos.toInt();
    } else {
      casaGanhadora = cartaEsquerda > cartaDireita ? 'PLAYER' : 'BANKER';
    }

    //dialog resultado
    await DialogResultado.mostrarResultado(
      context: context,
      casaGanhadora: casaGanhadora,
      valorGanhos: valorGanhos,
      ganhou: ganhou,
    );

    //evita do jogo continuar após os rounds acabarem
    if (_roundsRestantes != 0) {
      setState(() {
        _zerarApostas();
        timerAtivo = true;
        _showTimer = true;
        _showCartas = false;
      });
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
              if (_showTimer) TimerWidget(onTimerFinish: _ativarCartas),
              if (_showCartas)
                CartasAnimadas(
                  onTimerFinish: () {},
                  onResultado: _calcularGanho,
                ),
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
            child: RodadasWidget(
              roundsRestantes: _roundsRestantes,
              onNewRound: _zerarApostas,
            ),
          ),
        ],
      ),
    );
  }
}

//layout do botão jogar
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

//layout do inputtext
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
