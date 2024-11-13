import 'package:flutter/material.dart';

class BottonsAdicionarAposta extends StatefulWidget {
  final Function(int) onSelecionarValor;

  const BottonsAdicionarAposta({super.key, required this.onSelecionarValor});

  @override
  // ignore: library_private_types_in_public_api
  _BottonsAdicionarApostaState createState() => _BottonsAdicionarApostaState();
}

//botões dos valores de apostas
class _BottonsAdicionarApostaState extends State<BottonsAdicionarAposta> {
  final List<int> _valorAposta = [5, 10, 30, 125, 500, 1000];
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(_valorAposta.length, (index) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedIndex = index;
                widget.onSelecionarValor(_valorAposta[index]);
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size(0, 60),
              shape: CircleBorder(
                side: BorderSide(
                  color: _selectedIndex == index
                      ? Colors.black
                      : Colors.deepPurple,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              _valorAposta[index] == 1000 ? '1k' : '${_valorAposta[index]}',
              style: const TextStyle(fontSize: 24),
            ),
          );
        }),
      ),
    );
  }
}
